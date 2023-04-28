import 'package:dartz/dartz.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';

abstract class PokemonSearchRepository {
  Future<Either<Failure, Pokemon>> getPokemon(String name);
}
