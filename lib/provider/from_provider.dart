import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/formModel/form_model.dart';

class FormProvider with ChangeNotifier {
  List<FormModel> _forms = [];
  FormModel? _currentForm;
  Map<String, dynamic> _formData = {};
  Map<String, dynamic> _submissionData = {};

  List<FormModel> get forms => _forms;
  FormModel? get currentForm => _currentForm;
  Map<String, dynamic> get formValues => _formData;
  Map<String, dynamic> get submissionData => _submissionData;

  Future<void> loadForms() async {
    try {
      final form1 = await rootBundle.loadString('assets/form_1.json');
      final form2 = await rootBundle.loadString('assets/form_2.json');
      final form3 = await rootBundle.loadString('assets/form_3.json');

      _forms = [
        FormModel.fromJson(json.decode(form1)),
        FormModel.fromJson(json.decode(form2)),
        FormModel.fromJson(json.decode(form3)),
      ];
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading forms: $e');
    }
  }

  void setCurrentForm(FormModel form) {
    _currentForm = form;
    _formData = {};
    notifyListeners();
  }

  void updateFormData(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  void updateFieldValue(String key, dynamic value) {
    _formData[key] = value;
    notifyListeners();
  }

  void submitForm() {
    _submissionData = Map.from(_formData);
    notifyListeners();
  }

  void clearSubmission() {
    _submissionData = {};
    notifyListeners();
  }
}
