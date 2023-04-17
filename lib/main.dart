import 'package:flutter/material.dart';
import 'package:poke_app/core/pages/pages.dart';
import 'package:poke_app/features/pokemon_search/presentation/pages/search_result_page.dart';
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
        routes: {'home': (_) => SearchPage()},
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)));
  }
}
