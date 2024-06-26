import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late final SharedPreferences prefs;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    this.prefs = prefs;
  }
}
