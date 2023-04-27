import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:poke_app/core/entities/pokemon.dart';
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
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (_) => sl<FavoritesBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<FavoritesBloc, FavoritesState>(
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
                        instance: false,
                      );
                    } else if (state is LoadedList) {
                      if (state.pokemon.length > 1) {
                        return ListView.builder(
                          itemCount: state.pokemon.length,
                          itemBuilder: (context, index) => Dismissible(
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              db.deletePokemon(index);
                            },
                            child: ListTile(
                                title: Text(state.pokemon[index].name),
                                onTap: () => {
                                      LoadedFavorite(
                                          pokemon: state.pokemon[index])
                                    }),
                          ),
                        );
                      } else {
                        return Center(child: Text('No favorites added'));
                      }
                    } else {
                      return const Text('Fatal error');
                    }
                    return SizedBox(height: 10);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      )),
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
                Icons.arrow_back_rounded,
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
}
