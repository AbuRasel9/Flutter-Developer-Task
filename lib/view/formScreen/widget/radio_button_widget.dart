import 'package:flutter/material.dart';

import '../../../../model/formModel/dynamic_form_feild_model.dart';
import '../../../../provider/from_provider.dart';

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget(
      {super.key, required this.field, required this.formProvider});

  final DynamicFormField field;
  final FormProvider formProvider;

  @override
  Widget build(BuildContext context) {
    final value = formProvider.formValues[field.key];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.properties.label,
            style: Theme.of(context).textTheme.labelLarge),
        Row(
          children: [
            Radio(
              value: 'Yes',
              groupValue: value,
              onChanged: (val) => formProvider.updateFormData(field.key, val),
            ),
            const Text('Yes'),
            Radio(
              value: 'No',
              groupValue: value,
              onChanged: (val) => formProvider.updateFormData(field.key, val),
            ),
            const Text('No'),
          ],
        ),
      ],
    );
  }
}
