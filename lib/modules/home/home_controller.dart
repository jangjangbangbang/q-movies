// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late StreamSubscription<dynamic> subscription;
  final hasInternet = false.obs;

  @override
  void onInit() {
    super.onInit();
    // checkConnectivity();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.name != 'none') {
        hasInternet.value = true;

        Flushbar(
          backgroundColor: Colors.green,
          message:
              'Connected to the Internet - ${result.name == 'wifi' ? 'Wifi Network' : 'Mobile Network'}',
          flushbarStyle: FlushbarStyle.GROUNDED,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(Get.context!);
      } else {
        hasInternet.value = false;

        Flushbar(
          backgroundColor: Colors.red,
          message: 'No Internet - Check Network Connection',
          flushbarStyle: FlushbarStyle.GROUNDED,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(Get.context!);
      }
    });
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();

    if (result != ConnectivityResult.none) {
      hasInternet.value = true;
    } else {
      hasInternet.value = false;
    }
  }
}
