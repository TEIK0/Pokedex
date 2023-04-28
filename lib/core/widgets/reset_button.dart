import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';
import '../../features/pokemon_search/presentation/bloc/pokemon_search_bloc.dart';

class ResetButtonWidget extends StatelessWidget {
  final bool instance;
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

void resetState(BuildContext context, bool page) {
  if (page == true) {
    BlocProvider.of<PokemonSearchBloc>(context).add(const Reset());
  } else {
    BlocProvider.of<FavoritesBloc>(context).add(const ResetFavorite());
  }
}
