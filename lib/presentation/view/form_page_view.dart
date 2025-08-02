import 'package:bloc_clean_architecture/presentation/view/submission_view.dart';
import 'package:bloc_clean_architecture/provider/from_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/widget/dynamic_feild_widget.dart';
import '../../model/formModel/form_model.dart';

class FormPageView extends StatelessWidget {
  final FormModel form;
  const FormPageView({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FormProvider>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text(form.formName ?? "")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...?form.sections?.expand((section) => [
              Text(section.name ?? "",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...?section.fields
                  ?.map((field) => DynamicFieldWidget(field: field))
                  .toList(),
              const SizedBox(height: 16),
            ]),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SubmissionViewPage(
                          data: provider.getSubmissionData()),
                    ),
                  );
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
