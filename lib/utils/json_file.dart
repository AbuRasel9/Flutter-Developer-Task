import 'dart:convert';
import 'package:flutter/services.dart';

class JsonFile {
  static Future<List<Map<String, dynamic>>> loadForms() async {
    List<String> files = [
      'assets/form_1.json',
      'assets/form_2.json',
      'assets/form_3.json',
    ];

    List<Map<String, dynamic>> forms = [];
    for (String file in files) {
      String jsonString = await rootBundle.loadString(file);
      forms.add(json.decode(jsonString));
    }
    return forms;
  }
}
