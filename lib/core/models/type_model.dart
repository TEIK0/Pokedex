import 'core_models.dart';

class TypeModel {
  TypeModel({
    required this.slot,
    required this.type,
  });

  int slot;
  ListModel type;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        slot: json["slot"],
        type: ListModel.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}
