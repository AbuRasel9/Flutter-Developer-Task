import 'package:flutter/material.dart';

class SubmissionViewPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const SubmissionViewPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submission View")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: data.entries
            .map((e) => ListTile(
          title: Text(e.key),
          subtitle: Text(e.value.toString()),
        ))
            .toList(),
      ),
    );
  }
}
