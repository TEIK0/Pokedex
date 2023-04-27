import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/models/core_models.dart';
import 'package:poke_app/features/favorite_pokemon/domain/repositories/favorite_pokemon_repository.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/get_favorite_pokemon.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<FavoritePokemonRepository>()])
import 'get_favorite_pokemon_test.mocks.dart';

void main() {
  late GetFavoritePokemon getFavoritePokemon;
  late MockFavoritePokemonRepository mockFavoritePokemonRepository;
  setUp(() {
    mockFavoritePokemonRepository = MockFavoritePokemonRepository();
    getFavoritePokemon = GetFavoritePokemon(mockFavoritePokemonRepository);
  });
  const input = 123;
  final pokemonModel =
      PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));

  test('should delete a pokemon by row id', () async {
    when(mockFavoritePokemonRepository.getFavoritePokemon(any))
        .thenAnswer((_) async => Right(pokemonModel));
    final result = await getFavoritePokemon(input);
    expect(result, Right(pokemonModel));
    verify(mockFavoritePokemonRepository.getFavoritePokemon(input));
    verifyNoMoreInteractions(mockFavoritePokemonRepository);
  });
}
