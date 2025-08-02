import 'feild.dart';

class Section {
  String? name;
  String? key;
  List<Field>? fields;

  Section({
    this.name,
    this.key,
    this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    name: json["name"],
    key: json["key"],
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
  };
}
