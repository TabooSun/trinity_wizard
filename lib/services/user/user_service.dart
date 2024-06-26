import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';

class UserService extends GetxService {
  late List<UserDto> _users;

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

  List<UserDto> getUsers({
    required String searchTerm,
  }) {
    if (searchTerm.isEmpty) {
      return _users.toList(growable: false);
    }

    final FuzzyOptions<UserDto> fuzzyOptions = FuzzyOptions<UserDto>(
      threshold: .2,
      keys: <WeightedKey<UserDto>>[
        WeightedKey<UserDto>(
          name: 'user.firstName',
          getter: (UserDto x) => x.firstName,
          weight: 1,
        ),
        WeightedKey<UserDto>(
          name: 'user.lastName',
          getter: (UserDto x) => x.lastName,
          weight: 1,
        ),
        WeightedKey<UserDto>(
          name: 'user.id',
          getter: (UserDto x) => x.id,
          weight: 1,
        ),
      ],
    );
    return Fuzzy<UserDto>(
      _users,
      options: fuzzyOptions,
    )
        .search(searchTerm)
        .map((Result<UserDto> e) => e.item)
        .toList(growable: false);
  }

  void removeUser({required String id}) {
    _users = _users.where((UserDto user) => user.id != id).toList();
  }

  void updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
  }) {
    _users = _users.map((UserDto user) {
      if (user.id == id) {
        return user.copyWith(
          firstName: firstName,
          lastName: lastName,
          email: email,
          dob: dob,
        );
      }
      return user;
    }).toList();
  }
}
