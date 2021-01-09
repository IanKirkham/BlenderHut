import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/ingredient.dart';

//const TIMEOUT = 5;

const EMULATOR_IP = "10.0.2.2";
const PC_IP = "192.168.1.3";

const BASE_API_URL = 'http://' + EMULATOR_IP + ':3000/api/';

// Get a user
Future<http.Response> getUser(user) async {
  var url = BASE_API_URL + 'users/' + user.id;
  return await http.get(url);
}

// Log in user
Future<http.Response> loginUser(username, password) async {
  var url = BASE_API_URL + 'users/login';
  return await http.post(url, body: {
    'username': username,
    'password': password,
  }); //.timeout(Duration(seconds: TIMEOUT));
}

// Register user
Future<http.Response> registerUser(username, password) async {
  var url = BASE_API_URL + 'users/register';
  return await http.post(url, body: {
    'username': username,
    'password': password,
  }); //.timeout(Duration(seconds: TIMEOUT));
}

// Get recipes
Future<http.Response> getRecipes(username) async {
  var url = BASE_API_URL + 'recipes/' + username;
  return await http.get(url);
}

// Create a recipe
Future<http.Response> createRecipe(recipe) async {
  var url = BASE_API_URL + 'recipes/create';
  return await http.post(url, body: {
    'title': recipe.title,
    'ingredients': recipe.ingredients,
    'amounts': recipe.amounts,
    'units': recipe.units,
    'user': recipe.user,
  });
}

// Edit a recipe
Future<http.Response> editRecipe(recipe) async {
  var url = BASE_API_URL + 'recipes/edit/' + recipe.id;
  return await http.put(url, body: {
    'title': recipe.title,
    'ingredients': recipe.ingredients,
    'amounts': recipe.amounts,
    'units': recipe.units,
    'user': recipe.user,
  });
}

// Delete a recipe
Future<http.Response> deleteRecipe(recipe) async {
  var url = BASE_API_URL + 'recipes/delete/' + recipe.id;
  return await http.delete(url);
}

// Get a list of all ingredients
Future<List<Ingredient>> getIngredientList() async {
  var url = BASE_API_URL + 'ingredients';
  http.Response response = await http.get(url);
  List<Ingredient> list = [];
  if (response.statusCode == 200) {
    var parsedJson = jsonDecode(response.body);
    list =
        (parsedJson as List).map((item) => Ingredient.fromJson(item)).toList();
  }
  return list;
}
