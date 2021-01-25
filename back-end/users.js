const express = require("express");
const mongoose = require('mongoose');
const argon2 = require("argon2");

const router = express.Router();

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  containers: [{
      label: String,
      ingredient: {type: mongoose.Schema.Types.ObjectId, ref: 'Ingredient'},
      percent_full: {type: Number, default: 0},      
    }
  ]
});

// This is a hook that will be called before a user record is saved,
// allowing us to be sure to salt and hash the password first.
userSchema.pre('save', async function(next) {
  // only hash the password if it has been modified (or is new)
  if (!this.isModified('password'))
    return next();

  try {
    // generate a hash. argon2 does the salting and hashing for us
    // @ts-ignore
    const hash = await argon2.hash(this.password);
    // override the plaintext password with the hashed one
    // @ts-ignore
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
    }).populate('containers.ingredient');

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

    // generate initial container data
    // first generate frozen containers
    var containers = [];
    for (var i = 1; i < 7; i++) {
      var Container = {label:"F"+i, ingredient:null, percent_full:0};
      containers.push(Container);
    }

    // now generate liquid containers
    for (var i = 1; i < 4; i++) {
      var Container = {label:"L"+i, ingredient:null, percent_full:0};
      containers.push(Container);
    }

    //TODO: DELETE THIS
      containers[0].ingredient = "5ff6703c0e68452ed40566a7";
      containers[0].percent_full = 50;

    // create a new user and save it to the database
    const user = new User({
      username: req.body.username,
      password: req.body.password,
      containers: containers,
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
    // @ts-ignore
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

// Edit container data
router.put('/:user/containers/:id', async (req, res) => {
  try {
    //  lookup user record
    const user = await User.findOne({
      _id: req.params.user
    });
    // Return an error if user does not exist.
    if (!user)
      return res.status(403).send({
        message: "Could not find user"
    });

    // // Return error if no container array is recieved
    // if (!req.body.ingredient) {
    //   return res.status(403).send({
    //     message: "No container data provided"
    //   });
    // }
    
    user["containers"].forEach((e) => {
      if (e._id == req.body._id) {
        e["ingredient"] = req.body.ingredient;
        e["percent_full"] = req.body.percent_full;
      }
    });

    await user.save();
    return res.send({
      user: user,
    });

  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

module.exports = {
  routes: router,
  model: User,
};