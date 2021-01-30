import 'package:blenderapp/models/recipe.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiService.dart';

class FavoritesNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  FavoritesNotifier([AsyncValue<List<String>> favorites])
      : super(favorites ?? const AsyncValue.loading()) {
    retrieveFavorites();
  }

  Future<void> retrieveFavorites() async {
    state = const AsyncValue.loading();
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var user = sharedPreferences.getString('user');
      List<Recipe> allRecipes = await getRecipes(user);
      List<Recipe> favorites =
          allRecipes.where((item) => item.favorite).toList();
      state = AsyncValue.data(favorites);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
