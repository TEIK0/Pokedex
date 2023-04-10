class ListModel {
  ListModel({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
