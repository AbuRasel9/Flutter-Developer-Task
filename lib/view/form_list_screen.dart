import 'package:bloc_clean_architecture/config/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/from_provider.dart';
import 'formScreen/form_screen.dart';

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
 final theme=context.theme;
    return Scaffold(
      appBar: AppBar(title: const Text('Available Forms')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: formProvider.forms.length,
          itemBuilder: (context, index) {
            final form = formProvider.forms[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: theme.colorScheme.onPrimary

              ),
              child: ListTile(
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
