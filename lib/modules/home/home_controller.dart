// ignore_for_file: lines_longer_than_80_chars

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Future<bool> onWillPop() async {
    var backButtonPressedTime = DateTime.now();
    final difference = DateTime.now().difference(backButtonPressedTime);
    final isExitWarning = difference >= const Duration(seconds: 2);

    backButtonPressedTime = DateTime.now();

    if (isExitWarning) {
      await Fluttertoast.showToast(msg: 'Press back again to exit');
      return false;
    } else {
      await Fluttertoast.cancel();
      return true;
    }
  }
}
