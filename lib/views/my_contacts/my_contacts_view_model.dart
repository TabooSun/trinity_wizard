import 'package:get/get.dart';
import 'package:trinity_wizard/routes/route_collections.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/services/storage/storage_key_name.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/services/user/user_service.dart';
import 'package:trinity_wizard/views/contact_details/contact_details_view_model_data.dart';

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

  Future<void> editContact({required UserDto contact}) async {
    await Get.toNamed(
      RouteName.contactDetails,
      arguments: ContactDetailsViewModelData(
        userId: contact.id,
      ),
    );
    await fetchContacts(
      searchTerm: '',
    );
  }
}
