class Properties {
  String? type;
  String? defaultValue;
  String? hintText;
  int? minLength;
  int? maxLength;
  String? label;
  String? listItems;
  bool? multiSelect;
  bool? multiImage;

  Properties({
    this.type,
    this.defaultValue,
    this.hintText,
    this.minLength,
    this.maxLength,
    this.label,
    this.listItems,
    this.multiSelect,
    this.multiImage,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    type: json["type"],
    defaultValue: json["defaultValue"],
    hintText: json["hintText"],
    minLength: json["minLength"],
    maxLength: json["maxLength"],
    label: json["label"],
    listItems: json["listItems"],
    multiSelect: json["multiSelect"],
    multiImage: json["multiImage"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "defaultValue": defaultValue,
    "hintText": hintText,
    "minLength": minLength,
    "maxLength": maxLength,
    "label": label,
    "listItems": listItems,
    "multiSelect": multiSelect,
    "multiImage": multiImage,
  };
}
