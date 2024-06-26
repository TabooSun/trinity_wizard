import 'package:get/get.dart';
import 'package:trinity_wizard/routes/route_collections.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/services/storage/storage_key_name.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/services/user/user_service.dart';
import 'package:trinity_wizard/views/contact_details/contact_details_view_model_data.dart';

class MyProfileViewModel extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final UserService _userService = Get.find<UserService>();

  final Rxn<UserDto> contact = Rxn<UserDto>();

  @override
  void onInit() {
    fetchContactDetail();
    super.onInit();
  }

  Future<void> logout() async {
    await _storageService.prefs.remove(StorageKeyName.loggedInUserId);
    await Get.offAllNamed(RouteName.login);
  }

  void fetchContactDetail() {
    String? loggedInUserId =
        _storageService.prefs.getString(StorageKeyName.loggedInUserId);
    if (loggedInUserId == null) {
      return;
    }
    contact.value = _userService.getUserByIdOrEmail(
      credential: loggedInUserId,
    );
  }

  Future<void> editProfile() async {
    await Get.toNamed(
      RouteName.contactDetails,
      arguments: ContactDetailsViewModelData(
        userId: contact.value!.id,
      ),
    );
    fetchContactDetail();
  }
}
