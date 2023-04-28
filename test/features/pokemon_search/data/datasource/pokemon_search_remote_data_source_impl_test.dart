import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'pokemon_search_remote_data_source_impl_test.mocks.dart';

void main() {
  late PokemonSearchRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = PokemonSearchRemoteDataSourceImpl(client: mockHttpClient);
  });
  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('pokemon_search.json'), 200));
  }

  void setUpMockHttpClientFail404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('pokemon_search.json'), 404));
  }

  group('get Pokemon By Id', () {
    const input = "132";
    test('should Get a request on a URL whit number being the endpoint',
        () async {
      setUpMockHttpClientSuccess200();
      dataSource.getPokemon(input);
      verify(mockHttpClient.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/$input'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Pokemon by id when the response is 200(success)',
        () async {
      final pokemonModel =
          PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
      setUpMockHttpClientSuccess200();
      final result = await dataSource.getPokemon(input);
      expect(result, equals(pokemonModel));
    });

    test('should throw a ServerExeption when the response code is 404 or other',
        () async {
      setUpMockHttpClientFail404();
      final call = dataSource.getPokemon;
      expect(() => call(input), throwsA(isA<ServerException>()));
    });
  });

  group('get Pokemon by name', () {
    const name = 'ditto';
    test(
        'should Get a request on a URL whit string being the endpoint in random number',
        () async {
      setUpMockHttpClientSuccess200();
      dataSource.getPokemon(name);
      verify(mockHttpClient.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Pokemon by name when the response is 200(success)',
        () async {
      final pokemonModel =
          PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
      setUpMockHttpClientSuccess200();
      final result = await dataSource.getPokemon(name);
      expect(result, equals(pokemonModel));
    });

    test(
        'should throw a ServerExeption trying a random number when the response code is 404 or other',
        () async {
      setUpMockHttpClientFail404();
      final call = dataSource.getPokemon;
      expect(() => call(name), throwsA(isA<ServerException>()));
    });
  });
}
