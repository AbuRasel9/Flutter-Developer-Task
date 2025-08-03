import 'dynamic_form_feild_model.dart';
import 'form_feild.dart';

class FormModel {
  final String formName;
  final int id;
  final List<FormSection> sections;

  FormModel({
    required this.formName,
    required this.id,
    required this.sections,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      formName: json['formName'],
      id: json['id'],
      sections: (json['sections'] as List)
          .map((e) => FormSection.fromJson(e))
          .toList(),
    );
  }
}

class FormSection {
  final String name;
  final String key;
  final List<DynamicFormField> fields;

  FormSection({
    required this.name,
    required this.key,
    required this.fields,
  });

  factory FormSection.fromJson(Map<String, dynamic> json) {
    return FormSection(
      name: json['name'],
      key: json['key'],
      fields: (json['fields'] as List)
          .map((e) => DynamicFormField.fromJson(e))
          .toList(),
    );
  }
}
