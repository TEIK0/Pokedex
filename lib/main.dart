import 'package:flutter/material.dart';
import 'package:poke_app/features/pokemon_search/presentation/pages/search_page.dart';
import 'features/favorite_pokemon/presentation/pages/favorite_pokemon_page.dart';
import 'injections.dart' as inyection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inyection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        initialRoute: 'home',
        routes: {
          'home': (_) => SearchPage(),
          'favoriteList': (_) => FavoritesPage()
        },
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)));
  }
}
