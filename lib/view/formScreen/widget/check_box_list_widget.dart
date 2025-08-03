import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../model/formModel/dynamic_form_feild_model.dart';
import '../../../../provider/from_provider.dart';

class CheckBoxListWidget extends StatelessWidget {
  const CheckBoxListWidget({super.key, required this.field, required this.formProvider});
final DynamicFormField field;
final FormProvider formProvider;
  @override
  Widget build(BuildContext context) {
    final items = json.decode(field.properties.listItems) as List;
    final selectedItems = formProvider.formValues[field.key] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.properties.label, style: Theme.of(context).textTheme.labelLarge),
        ...items.map((item) {
          return CheckboxListTile(
            title: Text(item['name']),
            value: selectedItems.contains(item['value']),
            onChanged: (value) {
              final newList = List.from(selectedItems);
              if (value == true) {
                newList.add(item['value']);
              } else {
                newList.remove(item['value']);
              }
              formProvider.updateFormData(field.key, newList);
            },
          );
        }).toList(),
      ],
    );  }
}
