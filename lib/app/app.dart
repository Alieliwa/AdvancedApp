import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:advanced/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(); //default constructor
//named constructor
 MyApp._internal();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute ,
      theme: getApplicationTheme(),);
  }
}
