import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/error/exceptions.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/core/network/network_info.dart';
import 'package:poke_app/features/pokemon_search/data/datasources/pokemon_search_remote_data_source.dart';
import 'package:poke_app/features/pokemon_search/data/repositories/pokemon_search_repositoty_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks(
    [MockSpec<PokemonSearchRemoteDataSource>(), MockSpec<NetworkInfo>()])
import 'pokemon_search_repository_impl_test.mocks.dart';

void main() {
  late PokemonSearchRepositoryImpl repository;
  late MockPokemonSearchRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPokemonSearchRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonSearchRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('get Pokemon by id', () {
    const input = 132;
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
    final Pokemon tryPokemon = pokemonModel;
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getPokemonById(input);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.getPokemonById(any))
            .thenAnswer((_) async => pokemonModel);
        final result = await repository.getPokemonById(input);

        verify(mockRemoteDataSource.getPokemonById(input));
        expect(result, equals(Right(tryPokemon)));
      });

      test('Should catch the data locally when the call is successfull',
          () async {
        when(mockRemoteDataSource.getPokemonById(any))
            .thenAnswer((_) async => pokemonModel);
        await repository.getPokemonById(input);

        verify(mockRemoteDataSource.getPokemonById(input));
      });
    });
  });
  group('get pokemon by name', () {
    const input = 'ditto';
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
    final Pokemon tryPokemon = pokemonModel;
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getPokemonByName(input);

      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('Should return remote data when the call is successfull', () async {
        when(mockRemoteDataSource.getPokemonByName(input))
            .thenAnswer((_) async => pokemonModel);
        final result = await repository.getPokemonByName(input);

        verify(mockRemoteDataSource.getPokemonByName(input));
        expect(result, equals(Right(tryPokemon)));
      });
    });
  });
}
