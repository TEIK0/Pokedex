import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/core/error/failure.dart';
import 'package:poke_app/core/models/core_models.dart';

import '../../../../core/error/exceptions.dart';

abstract class PokemonSearchRemoteDataSource {
  Future<Either<Failure, PokemonModel>> getPokemon(String name);
}

class PokemonSearchRemoteDataSourceImpl
    implements PokemonSearchRemoteDataSource {
  final http.Client client;

  PokemonSearchRemoteDataSourceImpl({required this.client});
  @override
  Future<Either<Failure, PokemonModel>> getPokemon(String pokemon) =>
      _getPokemonFromUrl('https://pokeapi.co/api/v2/pokemon/$pokemon');

  Future<Either<Failure, PokemonModel>> _getPokemonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Right(PokemonModel.fromJson(json.decode(response.body)));
    } else {
      return Left(ServerFailure());
    }
  }
}
