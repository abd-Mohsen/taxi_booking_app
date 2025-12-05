import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/views/components/custom_button.dart';
import 'components/count_down_timer.dart';
import 'components/my_drawer.dart';

class DriverAcceptedPage extends StatelessWidget {
  const DriverAcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    TaxiDataController taxiDataController = Get.find();
    DriverModel driver = taxiDataController.drivers[0]; //to get any driver to show his info

    return SafeArea(
      child: Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            foregroundColor: cs.onPrimary,
            backgroundColor: cs.primary,
            centerTitle: true,
            title: Text(
              "taxi booking test".tr,
              style: tt.titleSmall!.copyWith(color: cs.onPrimary),
            ),
          ),
          backgroundColor: cs.surface,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 34.0),
                child: Text(
                  "A driver accepted your request".tr,
                  style: tt.titleLarge!.copyWith(color: cs.onSurface),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(image: NetworkImage(driver.photo))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      driver.name,
                      style: tt.titleLarge!.copyWith(color: cs.onSurface),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.phone, color: cs.primary),
                  //       const SizedBox(width: 8),
                  //       Text(
                  //         driver.phone,
                  //         style: tt.titleMedium!.copyWith(color: cs.onSurface),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_car, color: cs.secondary, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        "${driver.vehicle.color} ${driver.vehicle.fullName()}",
                        style: tt.titleSmall!.copyWith(color: cs.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),
                  Text(
                    "estimated arrival time".tr,
                    style: tt.titleMedium!.copyWith(color: cs.onSurface, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: CountDownTimer(
                      startTime: DateTime.now(),
                      countdownDuration: const Duration(minutes: 10),
                      textStyle: tt.titleLarge!.copyWith(color: cs.onSurface, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  isShort: true,
                  color: Colors.red,
                  child: Text(
                    "cancel ride".tr,
                    style: tt.titleMedium!.copyWith(color: cs.onPrimary),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
