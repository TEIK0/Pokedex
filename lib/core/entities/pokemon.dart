import 'package:equatable/equatable.dart';

import '../models/core_models.dart';

class Pokemon extends Equatable {
  int id;
  String name;
  SpritesModel sprites;
  List<StatModel> stats;
  List<TypeModel> types;

  Pokemon(
      {required this.name,
      required this.id,
      required this.sprites,
      required this.stats,
      required this.types});

  @override
  List<Object?> get props => [name, id, sprites, stats, types];
}
