import 'package:mms_app/core/routes/router.dart';

import 'base_vm.dart';

class SplashViewModel extends BaseModel {
  Future<void> goHome() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      navigate.navigateToReplacing(HomeScreen);
    });
  }
}
