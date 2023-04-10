import 'package:dartz/dartz.dart';
import 'package:poke_app/features/pokemon_search/domain/entities/pokemon_search.dart';

import '../../../../core/entities/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/pokemon_search_repository.dart';

class GetPokemonByName implements UseCase<PokemonSearch, String> {
  final PokemonSearchRepository repository;

  GetPokemonByName(this.repository);

  @override
  Future<Either<Failure, PokemonSearch>> call(String name) async {
    return await repository.getPokemonByName(name);
  }
}
