import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/core/usecases/usecases.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/show_favorite_pokemon_list.dart';
import 'package:poke_app/features/favorite_pokemon/domain/repositories/favorite_pokemon_repository.dart';
import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<FavoritePokemonRepository>()])
import 'show_favorite_pokemon_list_test.mocks.dart';

void main() {
  late ShowFavoritePokemonList showFavoritePokemonList;
  late MockFavoritePokemonRepository mockFavoritePokemonRepository;
  setUp(() {
    mockFavoritePokemonRepository = MockFavoritePokemonRepository();
    showFavoritePokemonList =
        ShowFavoritePokemonList(mockFavoritePokemonRepository);
  });
  final pokemonModel =
      PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));

  List<PokemonModel> expected = List.generate(10, (index) => pokemonModel);

  test('should show favorites pokemon list', () async {
    when(mockFavoritePokemonRepository.showFavoritePokemonList())
        .thenAnswer((_) async => Right(expected));
    final result = await showFavoritePokemonList(NoParams());
    expect(result, Right(expected));
    verify(mockFavoritePokemonRepository.showFavoritePokemonList());
    verifyNoMoreInteractions(mockFavoritePokemonRepository);
  });
}
