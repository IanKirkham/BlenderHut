const express = require("express");
const mongoose = require('mongoose');
const argon2 = require("argon2");

const router = express.Router();

const ingredientSchema = new mongoose.Schema({
  name: String,
  color: Number,
  icon: Number,
});

// create a User model from the User schema
const Ingredient = mongoose.model('Ingredient', ingredientSchema);

/* API Endpoints */

// Get an ingredient
router.get('/:id', async (req, res) => {
  try {
    const ingredient = await Ingredient.findOne({
      _id: req.params.id
    });
    if (!ingredient) {
      return res.status(404).send({
        message: "Could not find ingredient"
      });
    }
    return res.send({
      ingredient: ingredient
    });
  } catch (error) {
    console.log(error);
    return res.sendStatus(500);
  }
});

module.exports = {
  routes: router,
  model: Ingredient,
};