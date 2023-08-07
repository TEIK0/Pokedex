import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/usecases/usecases.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/delete_favorite_pokemon.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/get_favorite_pokemon.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/show_favorite_pokemon_list.dart';

import '../../../../core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';
import '../../data/repositories/favorite_pokemon_repository_impl.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritePokemonRepositoryImpl repository;
  FavoritesBloc({required this.repository}) : super(Empty()) {
    on<GetPokemonFromFavoriteList>((event, emit) async {
      emit(Loading());
      final failOrPass = await repository.getFavoritePokemon(event.input);
      _eitherLoadedOrErrorStateGettingFavorite(failOrPass);
    });
    on<GetPokemonFavoritesListFromDB>((event, emit) async {
      emit(Loading());
      final failOrPass = await repository.showFavoritePokemonList();
      _eitherLoadedOrErrorStateGettingList(failOrPass);
    });
    on<DeleteFavoritePokemonFromDB>((event, emit) async {
      emit(Loading());
      await repository.deleteFavoritePokemon(event.input);
      final failOrPass = await repository.showFavoritePokemonList();
      _eitherLoadedOrErrorStateGettingList(failOrPass);
    });
    on<ResetFavorite>((event, emit) async {
      emit(Empty());
    });
  }

  void _eitherLoadedOrErrorStateGettingFavorite(
      Either<Failure, Pokemon> failOrPass) async {
    emit(failOrPass.fold((failure) => const Error(message: 'Error'),
        (pokemon) => LoadedFavorite(pokemon: pokemon)));
  }

  void _eitherLoadedOrErrorStateGettingList(
      Either<Failure, List<Pokemon>> failOrPass) async {
    emit(failOrPass.fold((failure) => const Error(message: 'Error'),
        (pokemon) => LoadedList(pokemon: pokemon)));
  }
}
