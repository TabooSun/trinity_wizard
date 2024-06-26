import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/services/storage/storage_key_name.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/services/user/user_service.dart';

class MyContactsViewModel extends GetxController {
  final UserService _userService = Get.find<UserService>();
  final StorageService _storageService = Get.find<StorageService>();

  final RxList<UserDto> contacts = <UserDto>[].obs;

  Future<void> fetchContacts({
    required String searchTerm,
  }) async {
    contacts.value = _userService.getUsers(
      searchTerm: searchTerm,
    );
  }

  bool checkIsMe({
    required UserDto user,
  }) {
    String? loggedInUserId =
        _storageService.prefs.getString(StorageKeyName.loggedInUserId);
    return user.id == loggedInUserId;
  }
}
