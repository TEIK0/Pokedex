import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/loading_display.dart';
import '../../../../../core/widgets/message_display.dart';
import '../../../../../core/widgets/pokemon_result_display.dart';
import '../notifiers/search_notifier.dart';

class SearchNotifierPage extends StatefulWidget {
  @override
  State<SearchNotifierPage> createState() => _SearchPageNotifierState();
}

class _SearchPageNotifierState extends State<SearchNotifierPage> {
  final controller = TextEditingController();
  late String input;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    final isLoading = context.select((SearchNotifier n) => n.isLoading);
    final error = context.select((SearchNotifier n) => n.error);
    final pokemon = context.select((SearchNotifier n) => n.pokemon);
    final called = context.select((SearchNotifier n) => n.called);
    if (!isLoading! && called == false) {
      return emptyStateShow(context);
    } else if (error != null) {
      return MessageDisplay(
        message: error,
      );
    } else if (isLoading) {
      return LoadingDisplay();
    } else if (!isLoading && called == true) {
      return PokemonResultDisplay(
        pokemon: pokemon!,
        instance: "SearchProvider",
      );
    } else {
      return const Text('Fatal error');
    }
  }

  Center emptyStateShow(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Buscar pokemon',
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2)),
          width: 300,
          child: TextField(
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              input = value;
            },
            onSubmitted: (_) {
              context.read<SearchNotifier>().searchPokemon(input);
            },
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
      ]),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Pokedex',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
      actions: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'favoriteList');
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 50,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
