import 'package:bloc_clean_architecture/model/formModel/form_model.dart';
import 'package:flutter/cupertino.dart';

import '../repository/form_repository.dart';

class FormProvider extends ChangeNotifier{
  final FormRepository  _repository=FormRepository();
  List<FormModel>_forms=[];

  //get data
  List<FormModel> get fromData=>_forms;

  Map<String,dynamic>formValues={};
  ///fetch from data
  Future<void>fetchFormData()async{
    _forms=await _repository.fetchForms();
    notifyListeners();
  }
  void updateFeildValue(String key,dynamic value){
    formValues[key]=value;
    notifyListeners();
  }

  Map<String,dynamic>getSubmissionData(){
    return formValues;
  }
}