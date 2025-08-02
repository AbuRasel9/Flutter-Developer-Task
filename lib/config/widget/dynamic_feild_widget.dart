import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/field_model.dart';
import '../providers/form_provider.dart';

class DynamicFieldWidget extends StatelessWidget {
  final FieldModel field;
  const DynamicFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();

    switch (field.id) {
      case 1: // TextField
        return TextFormField(
          decoration: InputDecoration(labelText: field.properties['label']),
          validator: (value) {
            if ((value ?? '').length < field.properties['minLength']) {
              return "Minimum ${field.properties['minLength']} chars required";
            }
            return null;
          },
          onChanged: (value) => provider.updateFieldValue(field.key, value),
        );

      case 2: // DropDown or Checkbox
        final items = (field.properties['listItems'] as String);
        final list = List<Map<String, dynamic>>.from(
            (items.isNotEmpty) ? List<Map<String, dynamic>>.from((items as dynamic)) : []);
        if (field.properties['multiSelect']) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(field.properties['label']),
              ...list.map((item) {
                return CheckboxListTile(
                  title: Text(item['name']),
                  value: (provider.formValues[field.key] ?? []).contains(item['value']),
                  onChanged: (val) {
                    final selected = List<int>.from(provider.formValues[field.key] ?? []);
                    val == true ? selected.add(item['value']) : selected.remove(item['value']);
                    provider.updateFieldValue(field.key, selected);
                  },
                );
              })
            ],
          );
        } else {
          return DropdownButtonFormField(
            decoration: InputDecoration(labelText: field.properties['label']),
            items: list
                .map((e) => DropdownMenuItem(
              value: e['value'],
              child: Text(e['name']),
            ))
                .toList(),
            onChanged: (value) => provider.updateFieldValue(field.key, value),
          );
        }

      case 3: // Yes/No/NA
        final options = ['Yes', 'No', 'NA'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(field.properties['label']),
            ...options.map((opt) {
              return RadioListTile(
                title: Text(opt),
                value: opt,
                groupValue: provider.formValues[field.key],
                onChanged: (value) =>
                    provider.updateFieldValue(field.key, value),
              );
            }),
          ],
        );

      case 4: // Image upload (camera/gallery)
        return ElevatedButton(
          onPressed: () {
            // এখানে image_picker ইউজ করতে হবে
          },
          child: Text(field.properties['label']),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
