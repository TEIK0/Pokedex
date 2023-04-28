import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/models/core_models.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon.dart';

import '../../../../core/database/db_provider.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/util/input_converter.dart';
import '../../data/datasources/pokemon_search_remote_data_source.dart';

part 'pokemon_search_event.dart';
part 'pokemon_search_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive or zero';

class PokemonSearchBloc extends Bloc<PokemonSearchEvent, PokemonSearchState> {
  final GetPokemon getPokemon;
  final InputConverter inputConverter;
  final PokemonSearchRemoteDataSourceImpl remoteDataSource;
  PokemonSearchBloc(
      {required this.getPokemon,
      required this.inputConverter,
      required this.remoteDataSource})
      : super(Empty()) {
    on<GetSearchedPokemon>((event, emit) async {
      emit(Loading());
      final failureOrPokemon = await getPokemon(event.input);
      _eitherLoadedOrErrorState(failureOrPokemon);
    });
    on<Reset>((event, emit) async {
      emit(Empty());
    });
    on<AddFavorite>((event, emit) async {
      emit(Loading());
      final remotePokemon = await remoteDataSource.getPokemon(event.input);
      _eitherLoadedOrErrorAdd(remotePokemon);
    });
  }

  void _eitherLoadedOrErrorState(
      Either<Failure, Pokemon> failureOrPokemon) async {
    emit(failureOrPokemon.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (pokemon) => Loaded(pokemon: pokemon)));
  }

  void _eitherLoadedOrErrorAdd(
      Either<Failure, Pokemon> failureOrPokemon) async {
    emit(failureOrPokemon.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (pokemon) => pass(pokemon)));
  }

  PokemonSearchState pass(Pokemon pokemon) {
    DBProvider.db.newPokemon(pokemon as PokemonModel);
    return (Loaded(pokemon: pokemon));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
