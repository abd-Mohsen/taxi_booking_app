import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';
import 'package:taxi_booking_app/views/componenets/category_card.dart';

class TripSelector extends StatelessWidget {
  const TripSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GetBuilder<HomeController>(builder: (homeController) {
      return AnimatedContainer(
        padding: const EdgeInsets.all(22),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trip Details".tr,
                  style: tt.titleSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    homeController.toggleHiddenPanel();
                  },
                  icon: Icon(
                    homeController.isPanelHidden ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
                    color: cs.primary,
                    size: 35,
                  ),
                )
              ],
            ),
            Visibility(
              visible: !homeController.isPanelHidden,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          backgroundColor: cs.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Select Start".tr,
                          style: tt.labelMedium?.copyWith(color: cs.onPrimary),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          //
                        },
                        icon: Icon(Icons.my_location, color: cs.primaryContainer, size: 23),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      backgroundColor: cs.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Select Destination".tr,
                      style: tt.labelMedium?.copyWith(color: cs.onPrimary),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                        name: "economy",
                        selected: homeController.selectedCarType == "economy",
                        onCategoryChange: () {},
                      ),
                      CategoryCard(
                        name: "comfort",
                        selected: homeController.selectedCarType == "comfort",
                        onCategoryChange: () {},
                      ),
                      CategoryCard(
                        name: "premium",
                        selected: homeController.selectedCarType == "premium",
                        onCategoryChange: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance", style: tt.titleSmall!.copyWith(color: cs.onSurface)),
                      Text(
                        "${homeController.distance.toStringAsFixed(2)} km",
                        style: tt.titleSmall!.copyWith(color: cs.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Estimated Fare", style: tt.titleSmall!.copyWith(color: cs.onSurface)),
                      Text(
                        "${homeController.expectedFare.toStringAsFixed(2)} ${"SYP".tr}",
                        style: tt.titleSmall!.copyWith(color: cs.onSurface),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
