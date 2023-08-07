import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';
import '../../features/pokemon_search/presentation/search_whit_bloc/bloc/pokemon_search_bloc.dart';
import '../../features/pokemon_search/presentation/search_whit_provider/notifiers/search_notifier.dart';

class ResetButtonWidget extends StatelessWidget {
  final String instance;
  const ResetButtonWidget({
    super.key,
    required this.instance,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        resetState(context, instance);
      },
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.restart_alt,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}

void resetState(BuildContext context, String instance) {
  if (instance == 'SearchBloc') {
    BlocProvider.of<PokemonSearchBloc>(context).add(const Reset());
  } else if (instance == 'SearchProvider') {
    var searchPokemon = context.read<SearchNotifier>().reset();
  } else if (instance == 'Favorite') {
    BlocProvider.of<FavoritesBloc>(context).add(const ResetFavorite());
  }
}
