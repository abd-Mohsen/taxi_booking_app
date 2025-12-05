import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_booking_app/controllers/home_controller.dart';

void main() {
  group('HomeController Initial Values', () {
    test('should initialize with correct default values', () {
      final controller = HomeController();

      // Selection modes are not active initially
      expect(controller.startSelectionMode, false);
      expect(controller.endSelectionMode, false);

      // Locations arent set initially
      expect(controller.startLocation, isNull);
      expect(controller.endLocation, isNull);
      expect(controller.myLocation, isNull);

      // drivers map is empty
      expect(controller.driverFromLocation.isEmpty, true);

      // init Car type is in the middle
      expect(controller.selectedCarType, 'comfort');

      // Distance & fare are initially zero
      expect(controller.distance, 0.0);
      expect(controller.expectedFare, 0.0);

      // Bottom panel is not hidden
      expect(controller.isPanelHidden, false);
    });
  });
}
