import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
