import 'package:equatable/equatable.dart';

import '../models/core_models.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final SpritesModel sprites;
  final List<StatModel> stats;
  final List<TypeModel> types;

  const Pokemon(
      {required this.name,
      required this.id,
      required this.sprites,
      required this.stats,
      required this.types});

  @override
  List<Object?> get props => [name, id];
}
