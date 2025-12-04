import 'package:get/get.dart';

class RequestRideController extends GetxController {
  bool isLoading = false;
  void toggleLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> requestRide() async {
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    // todo go to driver accepted page
    toggleLoading(false);
  }
}
