import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/services/user/user_service.dart';
import 'package:trinity_wizard/views/contact_details/contact_details_view_model_data.dart';

class ContactDetailsViewModel extends GetxController {
  final UserService _userService = Get.find<UserService>();

  late final ContactDetailsViewModelData _state;
  final Rxn<UserDto> contact = Rxn<UserDto>();

  @override
  void onInit() {
    _state = Get.arguments as ContactDetailsViewModelData;

    _fetchContactDetail();
    super.onInit();
  }

  void _fetchContactDetail() {
    contact.value = _userService.getUserByIdOrEmail(
      credential: _state.userId,
    );
  }

  Future<void> updateContact({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
  }) async {
    if (firstName.isEmpty || lastName.isEmpty) {
      await Get.defaultDialog(
        title: 'Error',
        middleText: 'First Name and Last Name are required',
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      );
      return;
    }
    const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(emailPattern).hasMatch(email)) {
      await Get.defaultDialog(
        title: 'Error',
        middleText: 'Invalid email',
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      );
      return;
    }
    _userService.updateUser(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      dob: dob,
    );
    Get.back();
  }

  void removeContact({required String id}) {
    _userService.removeUser(
      id: id,
    );
    Get.back();
  }
}
