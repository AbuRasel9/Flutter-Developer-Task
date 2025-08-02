import 'package:bloc_clean_architecture/config/routes/route_name.dart';
import 'package:bloc_clean_architecture/presentation/view/form_list_page_view.dart';
import 'package:flutter/material.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.formListpageView:
        return MaterialPageRoute(
          builder: (context) => const FormListPageView(),
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
