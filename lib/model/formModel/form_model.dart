// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_architecture/model/formModel/section.dart';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  String? formName;
  int? id;
  List<Section>? sections;

  FormModel({
    this.formName,
    this.id,
    this.sections,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
    formName: json["formName"],
    id: json["id"],
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "formName": formName,
    "id": id,
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}



