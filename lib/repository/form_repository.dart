
import 'package:bloc_clean_architecture/utils/json_file.dart';

import '../model/formModel/form_model.dart';

class FormRepository {
  Future<List<FormModel>> fetchForms() async {
    final jsonForms = await JsonFile.loadForms();
    return jsonForms.map((e) => FormModel.fromJson(e)).toList();
  }
}
