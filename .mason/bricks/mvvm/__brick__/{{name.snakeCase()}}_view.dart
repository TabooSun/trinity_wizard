import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:{{{importRoot}}}/{{name.snakeCase()}}_view_model.dart';

class {{name.pascalCase()}}View extends StatefulWidget {
  const {{name.pascalCase()}}View({
    super.key,
  });

  @override
  _{{name.pascalCase()}}ViewState createState() => _{{name.pascalCase()}}ViewState();
}

class _{{name.pascalCase()}}ViewState extends State<{{name.pascalCase()}}View> {
  final {{name.pascalCase()}}ViewModel vm = Get.find<{{name.pascalCase()}}ViewModel>();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
