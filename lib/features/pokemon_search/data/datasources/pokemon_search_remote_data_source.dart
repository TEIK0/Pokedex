import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_app/core/models/core_models.dart';

import '../../../../core/error/exceptions.dart';

abstract class PokemonSearchRemoteDataSource {
  Future<PokemonModel> getPokemonById(int number);
  Future<PokemonModel> getPokemonByName(String name);
}

class PokemonSearchRemoteDataSourceImpl
    implements PokemonSearchRemoteDataSource {
  final http.Client client;

  PokemonSearchRemoteDataSourceImpl({required this.client});
  @override
  Future<PokemonModel> getPokemonById(int number) =>
      _getPokemonFromUrl('https://pokeapi.co/api/v2/pokemon/$number');

  @override
  Future<PokemonModel> getPokemonByName(String name) =>
      _getPokemonFromUrl('https://pokeapi.co/api/v2/pokemon/$name');

  Future<PokemonModel> _getPokemonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
