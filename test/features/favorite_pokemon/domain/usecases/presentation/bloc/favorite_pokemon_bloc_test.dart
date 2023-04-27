import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:poke_app/core/models/pokemon_model.dart';
import 'package:poke_app/core/usecases/usecases.dart';
import 'package:poke_app/features/favorite_pokemon/data/repositories/favorite_pokemon_repository_impl.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/delete_favorite_pokemon.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/get_favorite_pokemon.dart';
import 'package:poke_app/features/favorite_pokemon/domain/usecases/show_favorite_pokemon_list.dart';
import 'package:poke_app/features/favorite_pokemon/presentation/bloc/favorites_bloc.dart';

import '../../../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([
  MockSpec<FavoritePokemonRepositoryImpl>(),
])
import 'favorite_pokemon_bloc_test.mocks.dart';

void main() {
  late FavoritesBloc bloc;
  late MockFavoritePokemonRepositoryImpl mock;

  setUp(() {
    mock = MockFavoritePokemonRepositoryImpl();
    bloc = FavoritesBloc(repository: mock);
  });

  test('initial State should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('Get Pokemon By Id', () {
    const tNumber = 132;
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));

    test('should get data from the concrete use case', () async {
      when(mock.getFavoritePokemon(any))
          .thenAnswer((_) async => Right(pokemonModel));
      bloc.add(const GetPokemonFromFavoriteList(tNumber));
      await untilCalled(mock.getFavoritePokemon(any));
      verify(mock.getFavoritePokemon(tNumber));
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      when(mock.getFavoritePokemon(any))
          .thenAnswer((_) async => Right(pokemonModel));
      final expected = [Loading(), LoadedFavorite(pokemon: pokemonModel)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonFromFavoriteList(tNumber));
    });
  });
  group('Get Favorite Pokemon List', () {
    final pokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
    test('should get data from the concrete use case', () async {
      List<PokemonModel> expected = List.generate(10, (index) => pokemonModel);
      when(mock.showFavoritePokemonList())
          .thenAnswer((_) async => Right(expected));
      bloc.add(const GetPokemonFavoritesListFromDB());
      await untilCalled(mock.showFavoritePokemonList());
      verify(mock.showFavoritePokemonList());
    });
    test('Should emit[Loading,Loaded] when data is gotten succesfully',
        () async {
      List<PokemonModel> pokemonList =
          List.generate(10, (index) => pokemonModel);
      when(mock.showFavoritePokemonList())
          .thenAnswer((_) async => Right(pokemonList));
      final expected = [Loading(), LoadedList(pokemon: pokemonList)];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const GetPokemonFavoritesListFromDB());
    });
  });

  group('should delete a pokemon from favorite list', () {
    const tNumber = 1;

    test('should acces a concrete list object', () async {
      when(mock.deleteFavoritePokemon(any))
          .thenAnswer((_) async => const Right(1));
      bloc.add(const DeleteFavoritePokemonFromDB(tNumber));
      await untilCalled(mock.deleteFavoritePokemon(any));
      verify(mock.deleteFavoritePokemon(tNumber));
    });
  });
}
