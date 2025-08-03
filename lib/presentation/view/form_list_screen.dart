import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/from_provider.dart';
import 'form_screen.dart';

class FormListScreen extends StatefulWidget {
  const FormListScreen({super.key});

  @override
  State<FormListScreen> createState() => _FormListScreenState();
}

class _FormListScreenState extends State<FormListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FormProvider>(context, listen: false).loadForms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Available Forms')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: formProvider.forms.length,
          itemBuilder: (context, index) {
            final form = formProvider.forms[index];
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  form.formName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  formProvider.setCurrentForm(form);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormScreen(form: form),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
