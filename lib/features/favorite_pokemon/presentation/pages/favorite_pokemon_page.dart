import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:poke_app/core/widgets/pokemon_result_display.dart';
import 'package:poke_app/core/widgets/widgets.dart';
import 'package:poke_app/features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';

import '../../../../injections.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  late DBProvider db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: BlocProvider(
        create: (_) => sl<FavoritesBloc>(),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is Empty) {
              getFavoritesList(context);
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            } else if (state is Loading) {
              LoadingDisplay();
            } else if (state is LoadedFavorite) {
              return PokemonResultDisplay(
                pokemon: state.pokemon,
                instance: "Favorite",
              );
            } else if (state is LoadedList) {
              if (state.pokemon.isNotEmpty) {
                return listView(state);
              } else {
                return Center(
                    child: Column(
                  children: const [
                    SizedBox(height: 150),
                    Text(
                      'No favorites added',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Please add some',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: Image(
                            image: AssetImage('assets/pokeball.png'),
                            fit: BoxFit.cover))
                  ],
                ));
              }
            } else {
              return const Text('Fatal error');
            }
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }

  ListView listView(LoadedList state) {
    return ListView.builder(
      itemCount: state.pokemon.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              border: Border.all(width: 2)),
          child: ListTile(
              title: Text(
                  "${state.pokemon[index].id} - ${state.pokemon[index].name}",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 21, 21, 21))),
              onTap: () =>
                  {getFavoritePokemon(context, state.pokemon[index].id)}),
        );
      },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      leading: Row(
        children: [
          const SizedBox(width: 10),
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.search,
                color: Colors.red,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              }),
        ],
      ),
      toolbarHeight: 80,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        'Pokedex',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
    );
  }

  void getFavoritesList(BuildContext context) {
    BlocProvider.of<FavoritesBloc>(context)
        .add(const GetPokemonFavoritesListFromDB());
  }

  void getFavoritePokemon(BuildContext context, int id) {
    BlocProvider.of<FavoritesBloc>(context).add(GetPokemonFromFavoriteList(id));
  }
}
