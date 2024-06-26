import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/root_binding.dart';
import 'package:trinity_wizard/routes/route_collections.dart';
import 'package:trinity_wizard/services/storage/storage_key_name.dart';
import 'package:trinity_wizard/services/storage/storage_service.dart';
import 'package:trinity_wizard/theme/theme_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const AsyncRootBinding().dependencies();
  final StorageService storageService = Get.find<StorageService>();
  final String? loggedInUserId =
      storageService.prefs.getString(StorageKeyName.loggedInUserId);
  runApp(MyApp(
    loggedInUserId: loggedInUserId,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.loggedInUserId,
  });

  final String? loggedInUserId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeConfig.light,
      themeMode: ThemeMode.light,
      initialBinding: const RootBinding(),
      initialRoute: loggedInUserId == null ? RouteName.login : RouteName.home,
      getPages: RouteCollections.routes,
    );
  }
}
