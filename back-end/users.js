const express = require("express");
const mongoose = require('mongoose');
const argon2 = require("argon2");

const router = express.Router();

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
});

// This is a hook that will be called before a user record is saved,
// allowing us to be sure to salt and hash the password first.
userSchema.pre('save', async function(next) {
  // only hash the password if it has been modified (or is new)
  if (!this.isModified('password'))
    return next();

  try {
    // generate a hash. argon2 does the salting and hashing for us
    const hash = await argon2.hash(this.password);
    // override the plaintext password with the hashed one
    this.password = hash;
    next();
  } catch (error) {
    console.log(error);
    next(error);
  }
});

// This is a method that we can call on User objects to compare the hash of the
// password the browser sends with the has of the user's true password stored in
// the database.
userSchema.methods.comparePassword = async function(password) {
  try {
    // note that we supply the hash stored in the database (first argument) and
    // the plaintext password. argon2 will do the hashing and salting and
    // comparison for us.
    const isMatch = await argon2.verify(this.password, password);
    return isMatch;
  } catch (error) {
    return false;
  }
};

// This is a method that will be called automatically any time we convert a user
// object to JSON. It deletes the password hash from the object. This ensures
// that we never send password hashes over our API, to avoid giving away
// anything to an attacker.
userSchema.methods.toJSON = function() {
  var obj = this.toObject();
  delete obj.password;
  return obj;
}

// create a User model from the User schema
const User = mongoose.model('User', userSchema);

/* API Endpoints */

// Get a user
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findOne({
      _id: req.params.id
    });

    if (!user) {
      return res.status(404).send({
        message: "Could not find user"
      });
    }
    // return user
    return res.send(user);
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

// Register a new user
router.post('/register', async (req, res) => {
  // Make sure that the form coming from the browser includes a username and a
  // passsword, otherwise return an error. A 400 error means the request was
  // malformed.

  if (!req.body.username || !req.body.password)
    return res.status(400).send({
      message: "Username and password are required"
    });

  try {

    //  Check to see if username already exists and if not send a 403 error. A 403
    // error means permission denied.
    const existingUser = await User.findOne({
      username: req.body.username
    });
    if (existingUser)
      return res.status(403).send({
        message: "Username already exists"
      });

    // create a new user and save it to the database
    const user = new User({
      username: req.body.username,
      password: req.body.password
    });
    await user.save();
    // send back a 200 OK response, along with the user that was created
    return res.send(user);
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

// login a user
router.post('/login', async (req, res) => {
  // Make sure that the form coming from the browser includes a username and a
  // password, otherwise return an error.
  if (!req.body.username || !req.body.password)
    return res.sendStatus(400);

  try {
    //  lookup user record
    const user = await User.findOne({
      username: req.body.username
    });
    // Return an error if user does not exist.
    if (!user)
      return res.status(403).send({
        message: "Username or password is wrong"
      });

    // Return the SAME error if the password is wrong. This ensure we don't
    // leak any information about which users exist.
    if (!await user.comparePassword(req.body.password))
      return res.status(403).send({
        message: "Username or password is wrong"
      });

    // return user
    return res.send(user);
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

module.exports = {
  routes: router,
  model: User,
};