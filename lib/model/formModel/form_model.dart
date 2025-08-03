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
          .map((section) => FormSection.fromJson(section))
          .toList(),
    );
  }
}

class FormSection {
  final String name;
  final String key;
  final List<FormField> fields;

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
          .map((field) => FormField.fromJson(field))
          .toList(),
    );
  }
}

class FormField {
  final int id;
  final String key;
  final FieldProperties properties;

  FormField({
    required this.id,
    required this.key,
    required this.properties,
  });

  factory FormField.fromJson(Map<String, dynamic> json) {
    return FormField(
      id: json['id'],
      key: json['key'],
      properties: FieldProperties.fromJson(json['properties']),
    );
  }
}

class FieldProperties {
  final String type;
  final String defaultValue;
  final String hintText;
  final int minLength;
  final int maxLength;
  final String label;
  final String listItems;
  final bool multiSelect;
  final bool multiImage;

  FieldProperties({
    required this.type,
    required this.defaultValue,
    required this.hintText,
    required this.minLength,
    required this.maxLength,
    required this.label,
    this.listItems = '',
    this.multiSelect = false,
    this.multiImage = false,
  });

  factory FieldProperties.fromJson(Map<String, dynamic> json) {
    return FieldProperties(
      type: json['type'],
      defaultValue: json['defaultValue'] ?? '',
      hintText: json['hintText'] ?? '',
      minLength: json['minLength'] ?? 0,
      maxLength: json['maxLength'] ?? 255,
      label: json['label'],
      listItems: json['listItems'] ?? '',
      multiSelect: json['multiSelect'] ?? false,
      multiImage: json['multiImage'] ?? false,
    );
  }
}