const mongoose = require('mongoose');
const express = require("express");
const router = express.Router();
const users = require("./users.js");

const User = users.model;

const recipeSchema = new mongoose.Schema({
  title: String,
  ingredients: Array,
  amounts: Array,
});

const Recipe = mongoose.model('Recipe', recipeSchema);

// get recipes -- will list recipes that a user has created
router.get('/', async (req, res) => {
  let recipes = [];
  try {
    recipes = await Recipe.find({
      user: req.user
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
router.post('/', async (req, res) => {
  const recipe = new Recipe({
    title: req.title,
    ingredients: req.ingredients,
    amounts: req.amounts,
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
router.put('/:id', async (req, res) => {
  try {
    recipe = await Recipe.findOne({
      _id: req.params.id
    });
    recipe.title = req.body.title;
    recipe.ingredients = req.body.ingredients;
    recipe.amounts = req.body.amounts;
    await recipe.save();
    return res.send({
      recipe: recipe
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

module.exports = {
  routes: router
}