import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../model/formModel/dynamic_form_feild_model.dart';
import '../../../../provider/from_provider.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key, required this.field, required this.formProvider});
  final DynamicFormField field;
  final FormProvider formProvider;

  @override
  Widget build(BuildContext context) {
    final items = json.decode(field.properties.listItems) as List;

    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: field.properties.label,
        hintText: field.properties.hintText,
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item['value'],
          child: Text(item['name']),
        );
      }).toList(),
      onChanged: (value) {
        formProvider.updateFormData(field.key, value);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }
}
