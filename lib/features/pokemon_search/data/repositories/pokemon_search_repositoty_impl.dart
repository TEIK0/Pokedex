import 'package:dartz/dartz.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';
import 'package:poke_app/features/pokemon_search/domain/repositories/pokemon_search_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class PokemonSearchRepositoryImpl implements PokemonSearchRepository {
  final PokemonSearchRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  PokemonSearchRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Pokemon>> getPokemonById(int number) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemonById(number);
        return Right(remotePokemon as Pokemon);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemonByName(name);
        return Right(remotePokemon as Pokemon);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
