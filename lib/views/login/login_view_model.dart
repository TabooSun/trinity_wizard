import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/routes/route_collections.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/services/storage/storage_key_name.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/services/user/user_service.dart';

class LoginViewModel extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final UserService _userService = Get.find<UserService>();

  Future<void> login({
    required String credential,
    required String password,
  }) async {
    final UserDto? userByIdOrEmail = _userService.getUserByIdOrEmail(
      credential: credential,
    );

    if (userByIdOrEmail == null) {
      await showDialog(
        context:Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('User not found'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    await _storageService.prefs.setString(
      StorageKeyName.loggedInUserId,
      userByIdOrEmail.id,
    );

    await Get.offAllNamed(
      RouteName.home,
    );
  }
}
