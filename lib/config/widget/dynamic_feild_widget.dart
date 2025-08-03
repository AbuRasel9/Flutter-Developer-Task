import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/formModel/dynamic_form_feild_model.dart';
import '../../model/formModel/form_feild.dart';
import '../../provider/from_provider.dart';

class DynamicFieldWidget extends StatelessWidget {
  final DynamicFormField field;

  const DynamicFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();
    final formValues = provider.formValues;

    switch (field.id ?? 0) {
      case 1: // TextField
        return TextFormField(
          decoration: InputDecoration(labelText: field.properties.label ?? ""),
          validator: (value) {
            if ((value ?? '').length < (field.properties?.minLength ?? 0)) {
              return "Minimum ${field.properties?.minLength ?? 0} characters required";
            }
            return null;
          },
          onChanged: (value) =>
              provider.updateFormData(field.key ?? "", value),
        );

      case 2: // Dropdown or Checkbox
        final itemsJson = field.properties?.listItems ?? "";
        List<Map<String, dynamic>> list = [];
        try {
          list = List<Map<String, dynamic>>.from(jsonDecode(itemsJson));
        } catch (e) {
          return const Text("Invalid list data");
        }

        if (field.properties?.multiSelect ?? false) {
          final selected = List<int>.from(formValues[field.key] ?? []);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(field.properties?.label ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              ...list.map((item) {
                final itemValue = item['value'];
                return CheckboxListTile(
                  title: Text(item['name']),
                  value: selected.contains(itemValue),
                  onChanged: (val) {
                    if (val == true && !selected.contains(itemValue)) {
                      selected.add(itemValue);
                    } else if (val == false) {
                      selected.remove(itemValue);
                    }
                    provider.updateFieldValue(field.key ?? "", selected);
                  },
                );
              }),
            ],
          );
        } else {
          return DropdownButtonFormField(
            decoration:
            InputDecoration(labelText: field.properties?.label ?? ""),
            value: formValues[field.key],
            items: list
                .map((e) => DropdownMenuItem(
              value: e['value'],
              child: Text(e['name']),
            ))
                .toList(),
            onChanged: (value) =>
                provider.updateFieldValue(field.key ?? "", value),
          );
        }

      case 3: // Yes/No/NA
        final options = ['Yes', 'No', 'NA'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(field.properties?.label ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            ...options.map((opt) {
              return RadioListTile(
                title: Text(opt),
                value: opt,
                groupValue: formValues[field.key],
                onChanged: (value) =>
                    provider.updateFieldValue(field.key ?? "", value),
              );
            }),
          ],
        );

      case 4: // Image upload
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(field.properties?.label ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  provider.updateFieldValue(field.key ?? "", image.path);
                }
              },
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 10),
            if ((formValues[field.key] ?? "").toString().isNotEmpty)
              Image.file(
                File(formValues[field.key]),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
