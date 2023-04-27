import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:poke_app/core/database/db_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/models/core_models.dart';

import '../../fixtures/fixture_reader.dart';
@GenerateMocks([DBProvider])
import 'db_provider_test.mocks.dart';

Future main() async {
  late Database database;
  late DBProvider base;
  late MockDBProvider taskService;
  final pokemonModel =
      PokemonModel.fromJson(json.decode(fixture('pokemon_search.json')));
  List<PokemonModel> taskList = List.generate(10, (index) => pokemonModel);
  setUpAll(() async {
    base = DBProvider as DBProvider;
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    taskService = MockDBProvider();
    when(taskService.newPokemon(any)).thenAnswer((_) async => 1);
    when(taskService.deletePokemon(any)).thenAnswer((_) async => 1);
    when(taskService.getPokemonById(any)).thenAnswer((_) async => pokemonModel);
    when(taskService.showFavoritePokemonList())
        .thenAnswer((_) async => taskList);
  });

  group('Database Test', () {
    test('sqflite version', () async {
      expect(await database.getVersion(), 0);
    });
    test('add Item to database', () async {
      var i = await taskService.newPokemon(pokemonModel);
      print(i);
    });
    test('delete the first Item', () async {
      await taskService.deletePokemon(0);
    });

    test('erase database', () async {
      await base.deleteAllPokemons();
    });

    test('print all pokemons', () async {
      var p = await taskService.showFavoritePokemonList();
      print(p);
    });
    test('Close db', () async {
      await database.close();
      expect(database.isOpen, false);
    });
  });
}
