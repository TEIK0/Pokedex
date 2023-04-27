import 'package:dartz/dartz.dart';

import '../../../../core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/favorite_pokemon_repository.dart';

class GetFavoritePokemon implements UseCase<Pokemon, int> {
  final FavoritePokemonRepository repository;

  GetFavoritePokemon(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(int index) async {
    return await repository.getFavoritePokemon(index);
  }
}
