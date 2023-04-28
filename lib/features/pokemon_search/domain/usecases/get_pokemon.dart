import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/entities/pokemon.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/pokemon_search_repository.dart';

class GetPokemon implements UseCase<Pokemon, String> {
  final PokemonSearchRepository repository;

  GetPokemon(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(String name) async {
    return await repository.getPokemon(name);
  }
}
