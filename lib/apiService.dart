import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/containerData.dart';
import 'models/ingredient.dart';
import 'models/recipe.dart';
import 'models/user.dart';

//const TIMEOUT = 5;
const EMULATOR_IP = "10.0.2.2";
const PC_IP = "192.168.1.3";

const BASE_API_URL = 'http://' + EMULATOR_IP + ':3000/api/';

// Get a user
Future<User> getUser(user) async {
  var url = BASE_API_URL + 'users/' + user;
  var response = await http.get(url);
  User recievedUser;
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    print(json);
    recievedUser = User.fromJson(json);
  }
  return recievedUser;
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
Future<List<Recipe>> getRecipes(user) async {
  var url = BASE_API_URL + 'recipes/' + user;
  var response = await http.get(url);
  List<Recipe> list = [];
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    list = (json as List).map((item) => Recipe.fromJson(item)).toList();
  }
  return list;
}

// Create a recipe
Future<http.Response> createRecipe(Recipe recipe) async {
  var url = BASE_API_URL + 'recipes/create';
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String user = sharedPreferences.getString('user');
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  return await http.post(
    url,
    headers: headers,
    body: jsonEncode(
      {
        'title': recipe.title,
        'ingredients': recipe.ingredients,
        'amounts': recipe.amounts,
        'units': recipe.units,
        'user': user,
      },
    ),
  );
}

// Edit a recipe
Future<http.Response> updateRecipe(recipe) async {
  var url = BASE_API_URL + 'recipes/edit/' + recipe.id;
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  return await http.put(
    url,
    headers: headers,
    body: jsonEncode(
      {
        'title': recipe.title,
        'ingredients': recipe.ingredients,
        'amounts': recipe.amounts,
        'units': recipe.units,
        'user': recipe.user,
      },
    ),
  );
}

// Favorite a recipe
Future<http.Response> favoriteRecipe(id) async {
  var url = BASE_API_URL + 'recipes/favorite/' + id;
  return await http.put(url);
}

// Delete a recipe
Future<http.Response> deleteRecipe(id) async {
  var url = BASE_API_URL + 'recipes/delete/' + id;
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

// Get a specific ingredient
Future<Ingredient> getIngredient(id) async {
  var url = BASE_API_URL + 'ingredients/' + id;
  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);
  return Ingredient.fromJson(json);
}

// Edit container data
Future editContainer(String user, ContainerData container) async {
  var url = BASE_API_URL + 'users/' + user + "/containers/" + container.id;
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(
      {
        'ingredient':
            container.ingredient == null ? null : container.ingredient.id,
        'percent_full': container.percentFull,
        '_id': container.id,
      },
    ),
  );

  if (response.statusCode != 200) {
    print(response.body);
  }

  return;
}
