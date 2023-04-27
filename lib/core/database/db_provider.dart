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
    final path = join(documentsDirectory.path, "pokedex.db");
    print(path);

    // Returns database
    return await openDatabase(
      path,
      version: 2,
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
  Future<int> newRawPokemon(PokemonModel pokemon) async {
    final db = await database;
    final name = pokemon.name;
    final pokeId = pokemon.id;
    final hp = pokemon.stats[0].baseStat;
    final attack = pokemon.stats[1].baseStat;
    final defense = pokemon.stats[2].baseStat;
    final specialA = pokemon.stats[3].baseStat;
    final specialD = pokemon.stats[4].baseStat;
    final speed = pokemon.stats[5].baseStat;
    final spriteUrl = pokemon.sprites.frontDefault;
    final type1 = pokemon.types[0].type.name;
    final String type2;
    if (pokemon.types.length > 1) {
      type2 = pokemon.types[0].type.name;
    } else {
      type2 = '';
    }

    return await db.rawInsert(''' 
      INSERT INTO Pokemon(name, pokeId, hp, attack, defense, specialA, specialD, speed, spriteURL, type1, type2)
      VALUES ('$name', '$pokeId', '$hp', '$attack', '$defense', '$specialA', '$specialD', '$speed', '$spriteUrl', '$type1', '$type2' )
    ''');
  }

  /// Inserts a [pokemon] in the database.
  Future<int> newPokemon(PokemonModel pokemon) async {
    final db = await database;
    return await db.insert(
        "Pokemon", {'id': pokemon.id, 'json': json.encode(pokemon.toJson())});
  }

  /// Returns an `PokemonModel` with [id] when found, if not `null`.
  Future<PokemonModel?> getPokemonById(int id) async {
    final db = await database;
    final response =
        await db.query("Pokemon", where: "id = ?", whereArgs: [id]);

    return response.isNotEmpty ? PokemonModel.fromJson(response.first) : null;
  }

  Future<Pokemon?> getPokemonByPokemonId(int id) async {
    final db = await database;
    final response =
        await db.query("Pokemon", where: "id = ?", whereArgs: [id]);

    return response.isNotEmpty ? PokemonModel.fromJson(response.first) : null;
  }

  /// Returns an `PokemonModel` list.
  Future<List<PokemonModel>> showFavoritePokemonList() async {
    final db = await database;
    final response = await db.query("Pokemon");

    return response.map((response) => _getPokemon(response)).toList();
  }

  PokemonModel _getPokemon(Map<String, Object?> response) {
    return PokemonModel.fromJson(
      json.decode(
        Map.from(response)['data'],
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
