import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/core/widgets/widgets.dart';
import 'package:poke_app/features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';

import '../entities/pokemon.dart';
import '../../features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';

class PokemonResultDisplay extends StatelessWidget {
  final Pokemon pokemon;
  final bool instance;
  const PokemonResultDisplay({
    super.key,
    required this.pokemon,
    required this.instance,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ResetButtonWidget(instance: instance),
            const SizedBox(
              height: 35,
            ),
            NameWidget(pokemon: pokemon),
            const SizedBox(
              height: 35,
            ),
            IdWidget(pokemon: pokemon),
            PokemonFrontWidget(pokemon: pokemon),
            FavoriteWidget(instance: instance, position: pokemon.id),
            const SizedBox(
              height: 35,
            ),
            TypeWidget(pokemon: pokemon, index: 0),
            const SizedBox(
              height: 35,
            ),
            if (pokemon.types.length > 1)
              TypeWidget(pokemon: pokemon, index: 1),
            const SizedBox(
              height: 35,
            ),
            StatRowWidget(pokemon: pokemon, position1: 0, position2: 1),
            const SizedBox(
              height: 35,
            ),
            StatRowWidget(pokemon: pokemon, position1: 2, position2: 5),
            const SizedBox(
              height: 35,
            ),
            SpecialStatWidget(pokemon: pokemon, position: 3),
            const SizedBox(
              height: 35,
            ),
            SpecialStatWidget(pokemon: pokemon, position: 4),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  final bool instance;
  final int position;
  const FavoriteWidget({
    super.key,
    required this.instance,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 12,
      heroTag: null,
      onPressed: () {
        favoriteAction(context, instance, position.toString());
      },
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.favorite,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}

class TypeWidget extends StatelessWidget {
  const TypeWidget({
    super.key,
    required this.pokemon,
    required this.index,
  });

  final Pokemon pokemon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Text(
        textAlign: TextAlign.center,
        pokemon.types[index].type.name,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class StatRowWidget extends StatelessWidget {
  const StatRowWidget({
    super.key,
    required this.pokemon,
    required this.position1,
    required this.position2,
  });

  final Pokemon pokemon;
  final int position1;
  final int position2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatWidget(pokemon: pokemon, position: position1),
        StatWidget(pokemon: pokemon, position: position2),
      ],
    );
  }
}

class PokemonFrontWidget extends StatelessWidget {
  const PokemonFrontWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pokemon.sprites.frontDefault,
      fit: BoxFit.cover,
      width: 300,
      height: 300,
    );
  }
}

class IdWidget extends StatelessWidget {
  const IdWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Text(
        textAlign: TextAlign.center,
        pokemon.id.toString(),
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Text(
        textAlign: TextAlign.center,
        pokemon.name,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SpecialStatWidget extends StatelessWidget {
  const SpecialStatWidget({
    super.key,
    required this.pokemon,
    required this.position,
  });

  final Pokemon pokemon;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            pokemon.stats[position].stat.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            pokemon.stats[position].baseStat.toString(),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  const StatWidget({
    super.key,
    required this.pokemon,
    required this.position,
  });

  final Pokemon pokemon;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              pokemon.stats[position].stat.name,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              pokemon.stats[position].baseStat.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void favoriteAction(BuildContext context, bool page, String pokemon) {
  if (page == true) {
    BlocProvider.of<PokemonSearchBloc>(context).add(AddFavorite(pokemon));
  } else {
    BlocProvider.of<FavoritesBloc>(context)
        .add(DeleteFavoritePokemonFromDB(int.parse(pokemon)));
  }
}
