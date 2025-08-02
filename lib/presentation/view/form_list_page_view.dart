import 'package:bloc_clean_architecture/config/extension/context_ext.dart';
import 'package:bloc_clean_architecture/presentation/view/form_page_view.dart';
import 'package:bloc_clean_architecture/provider/from_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormListPageView extends StatefulWidget {
  const FormListPageView({super.key});

  @override
  State<FormListPageView> createState() => _FormListPageViewState();
}

class _FormListPageViewState extends State<FormListPageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FormProvider>().fetchFormData();

    },);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormProvider>();
final theme=context.theme;
    return Scaffold(
      appBar: AppBar(title: const Text("Form List")),
      body: provider.fromData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                    itemCount: provider.fromData.length,
                    itemBuilder: (context, index) {
            final form = provider.fromData[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormPageView(form: form),));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8,),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Colors.grey.withOpacity(.1)
                ),
                child: Text(form.formName ?? ""),

              ),
            );
                    },
                  ),
          ),
    );
  }
}
