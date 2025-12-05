import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/views/componenets/driver_marker.dart';

import '../services/remote_services/calculate_distance_service.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  GeoPoint? startLocation;
  GeoPoint? endLocation;

  MapController mapController = MapController(
    initMapWithUserPosition: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: true,
    ),
  );

  bool isMapLoaded = false;

  Map<GeoPoint, DriverModel> driverFromLocation = {};

  void addDriversMarkers(List<DriverModel> drivers) {
    if (!isMapLoaded) return;
    for (DriverModel driver in drivers) {
      GeoPoint location = GeoPoint(latitude: driver.location.latitude, longitude: driver.location.longitude);
      driverFromLocation[location] = driver;
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

  String selectedCarType = "comfort";

  void setCarType(String newValue) {
    selectedCarType = newValue;
    update();
  }

  double distance = 0.0;

  void calculateDistance() {
    if (startLocation == null || endLocation == null) return;
    distance = CalculateDistanceService().distanceInKm(
      startLocation!.latitude,
      startLocation!.longitude,
      endLocation!.latitude,
      endLocation!.longitude,
    );
    update();
  }

  double expectedFare = 0.0;

  void calculateFare() {
    //
  }

  bool isPanelHidden = false;

  void toggleHiddenPanel() {
    isPanelHidden = !isPanelHidden;
    update();
  }
}
