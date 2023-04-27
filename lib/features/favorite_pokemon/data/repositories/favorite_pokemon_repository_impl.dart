import 'package:dartz/dartz.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:poke_app/features/favorite_pokemon/domain/repositories/favorite_pokemon_repository.dart';

import '../../../../core/entities/pokemon.dart';
import '../../../../core/error/failure.dart';

class FavoritePokemonRepositoryImpl implements FavoritePokemonRepository {
  final DBProvider db;

  FavoritePokemonRepositoryImpl({required this.db});

  @override
  Future<Either<Failure, int>> deleteFavoritePokemon(int index) async {
    try {
      final result = await db.deletePokemon(index);
      return Right(result);
    } on Failure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getFavoritePokemon(int index) async {
    try {
      final result = await db.getPokemonByPokemonId(index);
      return Right(result!);
    } on Failure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> showFavoritePokemonList() async {
    try {
      final result = await db.showFavoritePokemonList();
      return Right(result);
    } on Failure {
      return Left(CacheFailure());
    }
  }
}
