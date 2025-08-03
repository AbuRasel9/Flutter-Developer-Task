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

