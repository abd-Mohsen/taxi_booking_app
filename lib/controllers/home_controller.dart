import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/controllers/current_location_controller.dart';
import 'package:taxi_booking_app/controllers/taxi_data_controller.dart';
import 'package:taxi_booking_app/models/driver_model.dart';
import 'package:taxi_booking_app/models/fare_rules_model.dart';
import 'package:taxi_booking_app/views/componenets/driver_marker.dart';
import 'package:taxi_booking_app/views/componenets/location_marker.dart';

import '../services/remote_services/calculate_distance_service.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        mapController.listenerMapSingleTapping.addListener(
          () async {
            if (startSelectionMode) {
              if (startLocation != null) mapController.removeMarker(startLocation!);
              startLocation = mapController.listenerMapSingleTapping.value!;
              await mapController.addMarker(
                startLocation!,
                markerIcon: const MarkerIcon(iconWidget: LocationMarker(start: true)),
              );
              toggleSelection(start: true, status: false);
            } else if (endSelectionMode) {
              if (endLocation != null) mapController.removeMarker(endLocation!);
              endLocation = mapController.listenerMapSingleTapping.value!;
              await mapController.addMarker(
                endLocation!,
                markerIcon: const MarkerIcon(iconWidget: LocationMarker(start: false)),
              );
              toggleSelection(start: false, status: false);
            }
          },
        );
      },
    );
    super.onInit();
  }

  bool startSelectionMode = false; // enabled when we wanna choose start location
  bool endSelectionMode = false; // enabled when we wanna choose end location

  void toggleSelection({bool start = true, bool status = true}) {
    if (start) {
      startSelectionMode = status;
      endSelectionMode = false;
    } else {
      endSelectionMode = status;
      startSelectionMode = false;
    }
    if (bothLocationsSelected) calculateDistance();
    if (bothLocationsSelected) calculateFare();
    update();
  }

  GeoPoint? startLocation;
  GeoPoint? endLocation;
  GeoPoint? myLocation;

  bool get bothLocationsSelected => startLocation != null && endLocation != null;

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

  void setMyLocation() async {
    CurrentLocationController currentLocationController = Get.find();
    if (currentLocationController.currentPosition == null) return;
    myLocation = GeoPoint(
      latitude: currentLocationController.currentPosition!.latitude,
      longitude: currentLocationController.currentPosition!.longitude,
    );
    if (startLocation != null) mapController.removeMarker(startLocation!);
    startLocation = myLocation;
    await mapController.addMarker(
      startLocation!,
      markerIcon: const MarkerIcon(iconWidget: LocationMarker(start: true)),
    );
    toggleSelection(start: true, status: false);
  }

  //-----------------------

  String selectedCarType = "comfort";

  void setCarType(String newValue) {
    selectedCarType = newValue;
    calculateFare();
    update();
  }

  //------------------------

  double distance = 0.0;

  void calculateDistance() {
    if (!bothLocationsSelected) return;
    distance = CalculateDistanceService().distanceInKm(
      startLocation!.latitude,
      startLocation!.longitude,
      endLocation!.latitude,
      endLocation!.longitude,
    );
    // update();
  }

  //--------------

  double expectedFare = 0.0;
  String currency = "SYP";

  void calculateFare() {
    TaxiDataController taxiDataController = Get.find();
    if (taxiDataController.fareRules == null) return;
    CarType carType = taxiDataController.fareRules!.perKmRate;
    double rate = selectedCarType == "economy"
        ? carType.economy
        : selectedCarType == "comfort"
            ? carType.comfort
            : carType.premium;
    expectedFare = rate * distance;
    currency = taxiDataController.fareRules!.currency;
  }

  //---------

  bool isPanelHidden = true;

  void toggleHiddenPanel() {
    isPanelHidden = !isPanelHidden;
    update();
  }
}
