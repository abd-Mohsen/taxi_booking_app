import 'package:get/get.dart';
import 'package:taxi_booking_app/views/driver_accepted_page.dart';

class RequestRideController extends GetxController {
  bool isLoading = false;
  void toggleLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> requestRide() async {
    toggleLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => DriverAcceptedPage());
    toggleLoading(false);
  }
}
