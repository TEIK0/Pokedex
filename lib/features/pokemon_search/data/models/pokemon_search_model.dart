// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromJson(jsonString);

import 'dart:convert';

import 'package:poke_app/core/entities/list_model.dart';
import 'package:poke_app/core/entities/sprites_model.dart';
import 'package:poke_app/core/entities/stat_model.dart';
import 'package:poke_app/core/entities/type_model.dart';

PokemonModel pokemonModelFromJson(String str) =>
    PokemonModel.fromJson(json.decode(str));

String pokemonModelToJson(PokemonModel data) => json.encode(data.toJson());

class PokemonModel {
  PokemonModel({
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.types,
  });

  int id;
  String name;
  SpritesModel sprites;
  List<StatModel> stats;
  List<TypeModel> types;

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
