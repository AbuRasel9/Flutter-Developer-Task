import 'form_feild.dart';

class DynamicFormField {
  final int id;
  final String key;
  final FieldProperties properties;

  DynamicFormField({
    required this.id,
    required this.key,
    required this.properties,
  });

  factory DynamicFormField.fromJson(Map<String, dynamic> json) {
    return DynamicFormField(
      id: json['id'],
      key: json['key'],
      properties: FieldProperties.fromJson(json['properties']),
    );
  }
}
