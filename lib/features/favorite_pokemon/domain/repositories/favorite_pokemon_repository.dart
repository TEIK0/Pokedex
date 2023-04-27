import 'package:dartz/dartz.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';

abstract class FavoritePokemonRepository {
  Future<Either<Failure, Pokemon>> getFavoritePokemon(int index);
  Future<Either<Failure, List<Pokemon>>> showFavoritePokemonList();
  Future<Either<Failure, int>> deleteFavoritePokemon(int index);
}
