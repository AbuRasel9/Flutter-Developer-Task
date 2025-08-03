import 'dart:convert';
import 'dart:io';

import 'package:bloc_clean_architecture/view/formScreen/widget/check_box_list_widget.dart';
import 'package:bloc_clean_architecture/view/formScreen/widget/drop_down_widget.dart';
import 'package:bloc_clean_architecture/view/formScreen/widget/radio_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../model/formModel/dynamic_form_feild_model.dart';
import '../../../model/formModel/form_model.dart';
import '../../../provider/from_provider.dart';
import '../submission_view.dart';

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
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
              child: Text("Submit")),
        ),
      ),
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
            ? CheckBoxListWidget(field: field, formProvider: formProvider)
            : DropDownWidget(field: field, formProvider: formProvider);

      case 3: // Yes/No
        return RadioButtonWidget(field: field, formProvider: formProvider);

      case 4: // Image
        return _buildImageField(field, formProvider);

      default:
        return const SizedBox();
    }
  }


  Widget _buildImageField(DynamicFormField field, FormProvider formProvider) {
    final ImagePicker _picker = ImagePicker();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.properties.label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            // Pick an image from gallery or camera
            final XFile? image = await _picker.pickImage(
              source: ImageSource.gallery,  // Use ImageSource.camera for camera
            );

            if (image != null) {
              // You can use the image.path to get the file path
              // and update your formProvider with the image
              formProvider.updateFormData(field.key, File(image.path));
            }
          },
          child: const Text("Upload Image"),
        ),
        const SizedBox(height: 8),
        // Consumer is used here to listen for changes in the form data
        Consumer<FormProvider>(
          builder: (context, formProvider, child) {
            final imageFile = formProvider.formValues[field.key] as File?;

            // Display the selected image if it exists
            return imageFile != null
                ? Image.file(imageFile) // Display the selected image
                : const SizedBox.shrink(); // Empty if no image is selected
          },
        ),
      ],
    );
  }

}
