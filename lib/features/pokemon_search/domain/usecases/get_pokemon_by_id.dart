import 'package:dartz/dartz.dart';
import 'package:poke_app/features/pokemon_search/domain/entities/pokemon_search.dart';

import '../../../../core/entities/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/pokemon_search_repository.dart';

class GetPokemonById implements UseCase<PokemonSearch, int> {
  final PokemonSearchRepository repository;

  GetPokemonById(this.repository);

  @override
  Future<Either<Failure, PokemonSearch>> call(int id) async {
    return await repository.getPokemonById(id);
  }
}
