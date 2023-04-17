import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poke_app/core/entities/pokemon.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/pokemon_search_repository.dart';

class GetPokemonById implements UseCase<Pokemon, int> {
  final PokemonSearchRepository repository;

  GetPokemonById(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(int id) async {
    return await repository.getPokemonById(id);
  }
}
