const mongoose = require('mongoose');
const express = require("express");
const router = express.Router();
const users = require("./users.js");
const ingredients = require("./ingredients.js");

const User = users.model;
const Ingredient = ingredients.model;

const recipeSchema = new mongoose.Schema({
  title: String,
  ingredients: [{type: mongoose.Schema.Types.ObjectId, ref: 'Ingredient'}],
  amounts: [Number],
  units: [String],
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User"
  },
  favorite: {
    type: Boolean, 
    defualt: false
  },
});

const Recipe = mongoose.model('Recipe', recipeSchema);

// var myRecipe = new Recipe({
//   title: "Example Recipe 1",
//   ingredients: ["Strawberry", "Peach", "Milk", "Banana", "Ice Cream"],
//   amounts: ["1", "3", "1/2", "3/4", "2"],
//   units: ["cup", "cups", "cup", "cup", "cups"],
//   user: ,
//   favorite: false,
// });
// myRecipe.save();

// get recipes -- will list recipes that a user has created
router.get('/:username', async (req, res) => {
  let recipes = [];
  try {
    recipes = await Recipe.find({
      username: req.params.username
    });
    return res.send({
      recipes: recipes
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

// create a recipe
router.post('/create', async (req, res) => {
  const recipe = new Recipe({
    title: req.body.title,
    ingredients: req.body.ingredients,
    amounts: req.body.amounts,
    units: req.body.units,
    user: req.body.username,
    favorite: false,
  });
  try {
    await recipe.save();
    return res.send({
      recipe: recipe
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

// edit a recipe
router.put('/edit/:id', async (req, res) => {
  try {
    var recipe = await Recipe.findOne({
      _id: req.params.id
    });
    recipe.title = req.body.title;
    recipe.ingredients = req.body.ingredients;
    recipe.amounts = req.body.amounts;
    recipe.units = req.body.units;
    await recipe.save();
    return res.send({
      recipe: recipe
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

// delete a recipe
router.delete('/delete/:id', async (req, res) => {
  try {
    await Recipe.findOneAndDelete({
      _id: req.params.id
    });
    res.sendStatus(200);
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

module.exports = {
  routes: router
}