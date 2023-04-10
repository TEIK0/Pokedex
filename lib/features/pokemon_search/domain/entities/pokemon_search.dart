import 'package:equatable/equatable.dart';
import 'package:poke_app/core/entities/sprites_model.dart';

import '../../../../core/entities/stat_model.dart';
import '../../../../core/entities/type_model.dart';

class PokemonSearch extends Equatable {
  int id;
  String name;
  SpritesModel sprites;
  List<StatModel> stats;
  List<TypeModel> types;

  PokemonSearch(
      {required this.name,
      required this.id,
      required this.sprites,
      required this.stats,
      required this.types});

  @override
  List<Object?> get props => [name, id, sprites, stats, types];
}
