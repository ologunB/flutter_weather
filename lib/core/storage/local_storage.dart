import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String kUserBox = 'userBox';
const String profileKey = 'profile';
const String isFirstKey = 'isTheFirst';

class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBox);
  }

  static Box<dynamic> get _userBox => Hive.box<dynamic>(kUserBox);

  static void haveFirstView(bool t) {
    if (isFirstKey == null) {
      return;
    }
    _userBox.put(isFirstKey, t);
  }

  static bool getIsFirst() {
    final bool data = _userBox.get(isFirstKey) ?? true;
    return data;
  }
}
