import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';

void main() {
  test('controller updates pickup and destination points', () {
    final controller = HomeController(); // we handle map interactions in home controller

    final pickup = GeoPoint(latitude: 24.7, longitude: 46.6);
    final destination = GeoPoint(latitude: 24.8, longitude: 46.7);

    controller.setStartLocation(pickup);
    controller.setEndLocation(destination);

    expect(controller.startLocation, pickup);
    expect(controller.endLocation, destination);
  });
}
