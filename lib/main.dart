import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/favorite_pokemon/presentation/pages/favorite_pokemon_page.dart';
import 'features/pokemon_search/presentation/search_whit_bloc/pages/search_page.dart';
import 'features/pokemon_search/presentation/search_whit_provider/notifiers/search_notifier.dart';
import 'features/pokemon_search/presentation/search_whit_provider/page/search_page_notifier.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchNotifier>(
          create: (_) => inyection.sl<SearchNotifier>(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pokedex',
          initialRoute: 'home',
          routes: {
            'home': (_) => SearchPage(),
            'provider': (_) => SearchNotifierPage(),
            'favoriteList': (_) => FavoritesPage()
          },
          theme:
              ThemeData(appBarTheme: const AppBarTheme(color: Colors.white))),
    );
  }
}
