import 'package:flutter/material.dart';
import 'package:pagosplux/Pages/login_page.dart';
import 'package:pagosplux/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      initialRoute: '/',
        routes: Routes.routes,
     );
   }
}
