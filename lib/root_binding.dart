import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/services/user/user_service.dart';

class RootBinding implements Bindings {
  const RootBinding();

  @override
  void dependencies() {
  }
}

class AsyncRootBinding implements Bindings {
  const AsyncRootBinding();

  @override
  Future<void> dependencies() async {
    await Get.putAsync<StorageService>(
      () async {
        final StorageService storageService = StorageService();
        await storageService.init();
        return storageService;
      },
    );
    await Get.putAsync<UserService>(
      () async {
        final UserService userService = UserService();
        await userService.init();
        return userService;
      },
    );
  }
}
