import 'core_models.dart';

class StatModel {
  StatModel({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  ListModel stat;

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
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
