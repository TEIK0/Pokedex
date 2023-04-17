import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/features/pokemon_search/domain/usecases/get_pokemon_by_name.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/get_pokemon_by_id.dart';

part 'pokemon_search_event.dart';
part 'pokemon_search_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive or zero';

class PokemonSearchBloc extends Bloc<PokemonSearchEvent, PokemonSearchState> {
  final GetPokemonByName getPokemonByName;
  final GetPokemonById getPokemonById;
  final InputConverter inputConverter;
  PokemonSearchBloc(
      {required this.getPokemonByName,
      required this.getPokemonById,
      required this.inputConverter})
      : super(Empty()) {
    on<GetPokemonForId>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInteger(event.input);
      await inputEither.fold(
        (failure) async =>
            emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
        (integer) async {
          emit(Loading());

          final failureOrTrivia = await getPokemonById(integer);

          _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    });
    on<GetPokemonForName>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getPokemonByName(event.input);
      _eitherLoadedOrErrorState(failureOrTrivia);
    });
  }

  void _eitherLoadedOrErrorState(
      Either<Failure, Pokemon> failureOrTrivia) async {
    emit(failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (pokemon) => Loaded(pokemon: pokemon)));
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
