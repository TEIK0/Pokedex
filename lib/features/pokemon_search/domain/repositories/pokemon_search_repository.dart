import 'package:dartz/dartz.dart';
import 'package:poke_app/features/pokemon_search/domain/entities/pokemon_search.dart';
import '../../../../core/entities/failure.dart';

abstract class PokemonSearchRepository {
  Future<Either<Failure, PokemonSearch>> getPokemonByName(String name);
  Future<Either<Failure, PokemonSearch>> getPokemonById(int id);
}
