import 'package:blenderapp/screens/home/favoritesNotifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/splash/splash.dart';

// final favoriteListProvider = FutureProvider<List<String>>((ref) async {
//   final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();
//   var user = sharedPreferences.getString('user');
//   List<Recipe> allRecipes = await getRecipes(user);
//   return allRecipes.map((item) => item.title).toList();
//   //return FavoriteList(allRecipes.where((item) => item.favorite).toList());
// });

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier>((ref) {
  return FavoritesNotifier();
});

void main() {
  runApp(ProviderScope(child: Main()));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: _theme(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlueAccent,
      ),
      appBarTheme: AppBarTheme(
        color: Color(0xFF1F2C34),
        elevation: 0,
      ),
      textTheme: TextTheme(
        headline3: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 40,
        ),
        headline4: GoogleFonts.montserrat(
          color: Colors.white,
        ),
        headline6: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 30,
        ),
        bodyText2: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 18,
        ),
        subtitle1: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      scaffoldBackgroundColor: Color(0xFF1F2C34),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF2F3D46),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF788388),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}
