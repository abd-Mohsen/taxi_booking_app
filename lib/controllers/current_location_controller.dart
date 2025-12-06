import 'dart:async';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';

class CurrentLocationController extends GetxController {
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    determinePosition();
  }

  Future<void> determinePosition() async {
    await Future.delayed(const Duration(seconds: 2));
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.dialog(kEnableLocationDialog(
        () async {
          if (await Geolocator.isLocationServiceEnabled()) {
            determinePosition();
            Get.back();
          }
        },
      ), barrierDismissible: false);
      return;
    }

    //Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // If permissions are granted, get the position

    try {
      currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (currentPosition == null) throw Exception();
    } catch (e) {
      determinePosition();
    }
  }
}
