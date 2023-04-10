import 'package:poke_app/core/entities/list_model.dart';

class StatEntity {
  StatEntity({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  ListModel stat;

  factory StatEntity.fromJson(Map<String, dynamic> json) => StatEntity(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: ListModel.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}
