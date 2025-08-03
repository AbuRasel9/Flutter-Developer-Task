import 'package:bloc_clean_architecture/config/routes/route_name.dart';
import 'package:bloc_clean_architecture/presentation/view/form_list_screen.dart';
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.formListScreen:
        return MaterialPageRoute(
          builder: (context) => const FormListScreen(),
        );
        case RouteName.formScreen:
        return MaterialPageRoute(
          builder: (context) => const FormListScreen(),
        );
        case RouteName.submissionScreen:
        return MaterialPageRoute(
          builder: (context) => const FormListScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No Page Found"),
            ),
          ),
        );
    }
  }
}
