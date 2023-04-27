import 'package:dartz/dartz.dart';
import 'package:poke_app/core/usecases/usecases.dart';

import '../../../../core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';
import '../repositories/favorite_pokemon_repository.dart';

class ShowFavoritePokemonList implements UseCase<List, NoParams> {
  final FavoritePokemonRepository repository;

  ShowFavoritePokemonList(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call(NoParams noParams) async {
    return await repository.showFavoritePokemonList();
  }
}
