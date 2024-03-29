import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/features/pokemon_search/presentation/search_whit_bloc/bloc/pokemon_search_bloc.dart';
import 'package:poke_app/injections.dart';
import '../../../../../core/widgets/widgets.dart';

import '../../../../../core/widgets/pokemon_result_display.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  late String input;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: BlocProvider(
        create: (_) => sl<PokemonSearchBloc>(),
        child: BlocBuilder<PokemonSearchBloc, PokemonSearchState>(
          builder: (context, state) {
            if (state is Empty) {
              return emptyStateShow(context);
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            } else if (state is Loading) {
              return LoadingDisplay();
            } else if (state is Loaded) {
              return PokemonResultDisplay(
                pokemon: state.pokemon,
                instance: "SearchBloc",
              );
            } else {
              return const Text('Fatal error');
            }
          },
        ),
      ),
    );
  }

  Widget emptyStateShow(BuildContext context) {
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
              dispatchPokemon(context, input);
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

void dispatchPokemon(BuildContext context, String input) {
  BlocProvider.of<PokemonSearchBloc>(context).add(GetSearchedPokemon(input));
}
