import 'package:bloc_clean_architecture/provider/from_provider.dart';
import 'package:bloc_clean_architecture/utils/theme/app_theme_data.dart';
import 'package:bloc_clean_architecture/view/form_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: MaterialApp(
        title: 'Dynamic Forms',
        theme: AppThemeData.lightThemeData,
        // Apply Light Theme
        themeMode: ThemeMode.light,
        // Automatically use system's theme setting
        home: const FormListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
