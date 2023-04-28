import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/models/core_models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  /// The database instance.
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  /// The database instance.
  Future<Database> get database async {
    // Returns database in case is already instanced
    if (_database != null) return _database!;

    // Initialize DB
    _database = await initDB();
    return _database!;
  }

  /// Initializes the database.
  Future<Database> initDB() async {
    // Path where is going to be stored the DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "pokemon.db");

    // Returns database
    return await openDatabase(
      path,
      version: 6,
      onCreate: (Database db, int version) async {
        await db.execute(''' 
            CREATE TABLE Pokemon(
              id INTEGER PRIMARY KEY,
              json TEXT
            )
          ''');
      },
    );
  }

  /// Inserts a [pokemon] in the database.
  Future<int> newPokemon(PokemonModel pokemon) async {
    final db = await database;
    await initDB();
    return await db.insert("Pokemon",
        {'id': pokemon.id.toInt(), 'json': json.encode(pokemon.toJson())});
  }

  /// Returns an `PokemonModel` with [id] when found, if not `null`.
  Future<Pokemon?> getPokemonByPokemonId(int id) async {
    final db = await database;

    final response =
        await db.query("Pokemon", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? _getPokemon(response.first) : null;
  }

  /// Returns an `PokemonModel` list.
  Future<List<PokemonModel>>? showFavoritePokemonList() async {
    final db = await database;
    final response = await db.query("Pokemon");
    return response.map((response) => _getPokemon(response)).toList();
  }

  PokemonModel _getPokemon(Map<String, Object?> response) {
    return PokemonModel.fromJson(
      json.decode(
        Map.from(response)['json'],
      ),
    );
  }

  /// Deletes the Pokemon with [id] in the database.
  Future<int> deletePokemon(int id) async {
    final db = await database;

    return await db.delete("Pokemon", where: "id = ?", whereArgs: [id]);
  }

  /// Deletes all Pokemons in the database.
  Future<int> deleteAllPokemons() async {
    final db = await database;

    return await db.delete("Pokemon");
  }
}
