import 'package:bloc_clean_architecture/provider/from_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes/route_name.dart';
import 'config/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FromProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.formListpageView,
      onGenerateRoute: Routes.generateRoute,

    ),
    );
  }
}
