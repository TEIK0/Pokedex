// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromJson(jsonString);

import 'dart:convert';
import 'package:poke_app/core/entities/pokemon.dart';
import 'package:poke_app/core/models/core_models.dart';

PokemonModel pokemonModelFromJson(String str) =>
    PokemonModel.fromJson(json.decode(str));

String pokemonModelToJson(PokemonModel data) => json.encode(data.toJson());

class PokemonModel extends Pokemon {
  const PokemonModel({
    required int id,
    required String name,
    required SpritesModel sprites,
    required List<StatModel> stats,
    required List<TypeModel> types,
  }) : super(id: id, name: name, sprites: sprites, stats: stats, types: types);

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        id: json["id"],
        name: json["name"],
        stats: List<StatModel>.from(
            json["stats"].map((x) => StatModel.fromJson(x))),
        types: List<TypeModel>.from(
            json["types"].map((x) => TypeModel.fromJson(x))),
        sprites: SpritesModel.fromJson(json["sprites"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };
}
