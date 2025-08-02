import 'package:bloc_clean_architecture/model/formModel/properties.dart';

class Field {
  int? id;
  String? key;
  Properties? properties;

  Field({
    this.id,
    this.key,
    this.properties,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    key: json["key"],
    properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "properties": properties?.toJson(),
  };
}
