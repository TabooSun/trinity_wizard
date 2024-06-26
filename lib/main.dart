import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/root_binding.dart';
import 'package:trinity_wizard/routes/route_collections.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      initialBinding: const RootBinding(),
      initialRoute: RouteConstant.home,
      getPages: RouteCollections.routes,
    );
  }
}
