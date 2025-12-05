import 'package:flutter_test/flutter_test.dart';
import 'package:taxi_booking_app/models/driver_model.dart';

void main() {
  test('parses driver correctly from JSON', () {
    final encodedJson = {
      "id": "d1",
      "name": "Ahmed Hassan",
      "phone": "+966501234567",
      "photo": "https://randomuser.me/api/portraits/men/1.jpg",
      "rating": 4.8,
      "total_trips": 1243,
      "vehicle": {
        "type": "Economy",
        "make": "Toyota",
        "model": "Camry",
        "year": 2022,
        "color": "White",
        "plate_number": "ABC 1234"
      },
      "location": {"latitude": 24.7136, "longitude": 46.6753},
      "is_available": true
    };

    final driver = DriverModel.fromJson(encodedJson);

    expect(driver.id, "d1");
    expect(driver.name, "Ahmed Hassan");
    expect(driver.rating, 4.8);
    expect(driver.isAvailable, true);
    expect(driver.vehicle.plateNumber, "ABC 1234");
  });
}
