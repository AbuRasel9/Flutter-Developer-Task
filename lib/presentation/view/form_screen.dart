import 'dart:convert';
import 'package:bloc_clean_architecture/presentation/view/submission_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/formModel/dynamic_form_feild_model.dart';
import '../../model/formModel/form_model.dart';
import '../../provider/from_provider.dart';

class FormScreen extends StatefulWidget {
  final FormModel form;

  const FormScreen({super.key, required this.form});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.form.formName)),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: widget.form.sections.map((section) {
              return _buildSection(section, formProvider);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            formProvider.submitForm();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubmissionScreen(),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildSection(FormSection section, FormProvider formProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            ...section.fields.map((field) {
              return _buildField(field, formProvider);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildField(DynamicFormField field, FormProvider formProvider) {
    switch (field.id) {
      case 1: // Text Field
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.properties.label,
            hintText: field.properties.hintText,
          ),
          minLines: 1,
          maxLines: field.properties.maxLength > 100 ? 3 : 1,
          maxLength: field.properties.maxLength,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (value.length < field.properties.minLength) {
              return 'Minimum ${field.properties.minLength} characters required';
            }
            return null;
          },
          onChanged: (value) {
            formProvider.updateFormData(field.key, value);
          },
        );

      case 2: // Dropdown or Checkbox
        return field.properties.multiSelect
            ? _buildCheckboxList(field, formProvider)
            : _buildDropdown(field, formProvider);

      case 3: // Yes/No
        return _buildYesNoField(field, formProvider);

      case 4: // Image
        return _buildImageField(field, formProvider);

      default:
        return const SizedBox();
    }
  }

  Widget _buildDropdown(DynamicFormField field, FormProvider formProvider) {
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

  Widget _buildCheckboxList(DynamicFormField field, FormProvider formProvider) {
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
    );
  }

  Widget _buildYesNoField(DynamicFormField field, FormProvider formProvider) {
    final value = formProvider.formValues[field.key];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.properties.label, style: Theme.of(context).textTheme.labelLarge),
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

  Widget _buildImageField(DynamicFormField field, FormProvider formProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.properties.label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // TODO: implement image picker
          },
          child: const Text("Upload Image"),
        ),
      ],
    );
  }
}
