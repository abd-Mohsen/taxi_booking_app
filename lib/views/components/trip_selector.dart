import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';
import 'package:taxi_booking_app/controllers/request_ride_controller.dart';

import 'category_card.dart';
import 'custom_button.dart';
import 'location_marker.dart';

class TripSelector extends StatelessWidget {
  const TripSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GetBuilder<HomeController>(builder: (homeController) {
      return AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                homeController.toggleHiddenPanel();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trip Details".tr,
                    style: tt.titleSmall?.copyWith(color: cs.secondary, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    homeController.isPanelHidden ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
                    color: cs.secondary,
                    size: 35,
                  )
                ],
              ),
            ),
            Visibility(
              visible: !homeController.isPanelHidden,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: cs.onSurface.withValues(alpha: 0.4),
                    indent: 4,
                    endIndent: 4,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: LocationMarker(start: true, size: 25),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              homeController.toggleSelection(start: true, status: !homeController.startSelectionMode);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              backgroundColor: homeController.startSelectionMode ? Colors.red : cs.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              homeController.startSelectionMode ? "select on map".tr : "Select Start".tr,
                              style: tt.labelSmall?.copyWith(color: cs.onPrimary),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 4),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                            child: LocationMarker(start: false, size: 25),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              homeController.toggleSelection(start: false, status: !homeController.endSelectionMode);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              backgroundColor: homeController.endSelectionMode ? Colors.red : cs.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              homeController.endSelectionMode ? "select on map".tr : "Select Destination".tr,
                              style: tt.labelSmall?.copyWith(color: cs.onPrimary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                        name: "economy",
                        selected: homeController.selectedCarType == "economy",
                        onCategoryChange: () {
                          homeController.setCarType("economy");
                        },
                      ),
                      CategoryCard(
                        name: "comfort",
                        selected: homeController.selectedCarType == "comfort",
                        onCategoryChange: () {
                          homeController.setCarType("comfort");
                        },
                      ),
                      CategoryCard(
                        name: "premium",
                        selected: homeController.selectedCarType == "premium",
                        onCategoryChange: () {
                          homeController.setCarType("premium");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance", style: tt.labelMedium!.copyWith(color: cs.onSurface)),
                      Text(
                        "${homeController.distance.toStringAsFixed(2)} KM",
                        style: tt.labelMedium!.copyWith(color: cs.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Estimated Fare", style: tt.labelMedium!.copyWith(color: cs.onSurface)),
                      Text(
                        "${homeController.expectedFare.toStringAsFixed(2)} ${homeController.currency.tr}",
                        style: tt.labelMedium!.copyWith(color: cs.onSurface, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  GetBuilder<RequestRideController>(
                    init: RequestRideController(),
                    builder: (requestRideController) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: CustomButton(
                          onTap: () {
                            if (!homeController.bothLocationsSelected) return;
                            requestRideController.requestRide(); //todo: show a dialog
                          },
                          color: homeController.bothLocationsSelected ? cs.primary : Colors.grey,
                          child: requestRideController.isLoading
                              ? SpinKitThreeBounce(
                                  size: 18,
                                  color: cs.onPrimary,
                                )
                              : Text(
                                  "request ride".tr,
                                  style: tt.labelMedium!.copyWith(color: cs.onPrimary),
                                ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
