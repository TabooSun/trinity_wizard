import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';

class UserService extends GetxService {
  late final List<UserDto> _users;

  Future<void> init() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    _users = (jsonDecode(jsonString) as List<dynamic>)
        .map((dynamic e) => UserDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  UserDto? getUserByIdOrEmail({
    required String credential,
  }) {
    return _users.firstWhereOrNull(
      (UserDto user) => user.id == credential || user.email == credential,
    );
  }
}
