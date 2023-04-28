import 'package:dartz/dartz.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/models/core_models.dart';
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

  Failure fails() {
    return ServerFailure();
  }

  PokemonModel pass(PokemonModel pokemon) {
    return pokemon;
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(String name) async {
    if (await networkInfo.isConnected) {
      final remotePokemon = await remoteDataSource.getPokemon(name);
      return remotePokemon.fold(
          (failure) => Left(failure), (pokemon) => Right(pokemon));
    }
    return Left(ServerFailure());
  }
}
