import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/views/componenets/driver_marker.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  MapController mapController = MapController(
    initMapWithUserPosition: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: true,
    ),
  );

  bool isMapLoaded = false;

  Map<GeoPoint, DriverModel> DriverFromLocation = {};

  void addDriversMarkers(List<DriverModel> drivers) {
    if (!isMapLoaded) return;
    for (DriverModel driver in drivers) {
      GeoPoint location = GeoPoint(latitude: driver.location.latitude, longitude: driver.location.longitude);
      this.DriverFromLocation[location] = driver;
      mapController.addMarker(
        location,
        markerIcon: MarkerIcon(iconWidget: DriverMarker(driver: driver)),
      );
    }
  }

  void onMapLoaded() async {
    isMapLoaded = true;
    TaxiDataController taxiDataController = Get.find();
    await taxiDataController.fetchTaxiData();
    addDriversMarkers(taxiDataController.drivers);
  }
}
