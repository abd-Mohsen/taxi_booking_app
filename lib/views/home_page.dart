import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/views/componenets/trip_selector.dart';

import 'componenets/blurred_sheet.dart';
import 'componenets/sheet_details_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          centerTitle: true,
          title: Text(
            "taxi booking test".tr,
            style: tt.titleSmall!.copyWith(color: cs.onPrimary),
          ),
        ),
        backgroundColor: cs.surface,
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (homeController) {
            return Stack(
              children: [
                GetBuilder<TaxiDataController>(
                  init: TaxiDataController(),
                  builder: (taxiDataController) {
                    return ModalProgressHUD(
                      inAsyncCall: taxiDataController.isLoading,
                      blur: 5,
                      progressIndicator: Center(child: CircularProgressIndicator(color: cs.primary)),
                      child: OSMFlutter(
                        controller: homeController.mapController,
                        mapIsLoading: Center(child: CircularProgressIndicator(color: cs.primary)),
                        onMapIsReady: (v) {
                          homeController.onMapLoaded();
                        },
                        onGeoPointClicked: (driverLocation) {
                          DriverModel driver = homeController.driverFromLocation[driverLocation]!;
                          showMaterialModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black.withValues(alpha: 0.5),
                            enableDrag: true,
                            builder: (context) => BlurredSheet(
                              title: "driver info".tr,
                              confirmText: "ok".tr,
                              onConfirm: () {
                                Get.back();
                              },
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SheetDetailsTile(
                                          title: "name".tr,
                                          subtitle: driver.name,
                                        ),
                                      ),
                                      Expanded(
                                        child: SheetDetailsTile(
                                          title: "vehicle type".tr,
                                          subtitle: driver.vehicle.type,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SheetDetailsTile(
                                          title: "plate number".tr,
                                          subtitle: driver.vehicle.plateNumber,
                                        ),
                                      ),
                                      Expanded(
                                        child: SheetDetailsTile(
                                          title: "vehicle name".tr,
                                          subtitle: driver.vehicle.fullName(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "rating".tr,
                                          style: tt.labelSmall!.copyWith(color: cs.onSurface.withValues(alpha: 0.5)),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 8),
                                        RatingBarIndicator(
                                          rating: driver.rating,
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 22.0,
                                          unratedColor: Colors.grey,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        osmOption: OSMOption(
                          zoomOption: const ZoomOption(initZoom: 12),
                          userLocationMarker: UserLocationMaker(
                            personMarker: MarkerIcon(
                              iconWidget: Icon(Icons.person, color: cs.primary, size: 70),
                            ),
                            directionArrowMarker: MarkerIcon(
                              iconWidget: Icon(Icons.person, color: cs.primary, size: 70),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: TripSelector(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
