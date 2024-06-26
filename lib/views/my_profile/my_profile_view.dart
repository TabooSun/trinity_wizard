import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/views/my_profile/my_profile_view_model.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({
    super.key,
  });

  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final MyProfileViewModel vm = Get.find<MyProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
