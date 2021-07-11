import 'package:flutter/material.dart';
import 'package:tp_flutter/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: kHomeRoute,
      routes: kRoutes,
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}
