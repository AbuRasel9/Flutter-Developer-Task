import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/from_provider.dart';

class SubmissionScreen extends StatelessWidget {
  const SubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final submissionData = formProvider.submissionData;

    return Scaffold(
      appBar: AppBar(title: const Text('Submission Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: submissionData.entries.map((entry) {
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Text(
                        entry.value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            // Implement save functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Submission saved successfully')),
            );
            formProvider.clearSubmission();
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
