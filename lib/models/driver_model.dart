import 'package:taxi_booking_app/models/vehicle_model.dart';

class DriverModel {
  final String id;
  final String name;
  final String phone;
  final String photo;
  final double rating;
  final int totalTrips;
  final VehicleModel vehicle;
  final Location location;
  final bool isAvailable;

  DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.photo,
    required this.rating,
    required this.totalTrips,
    required this.vehicle,
    required this.location,
    required this.isAvailable,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        photo: json["photo"],
        rating: json["rating"]?.toDouble(),
        totalTrips: json["total_trips"],
        vehicle: VehicleModel.fromJson(json["vehicle"]),
        location: Location.fromJson(json["location"]),
        isAvailable: json["is_available"],
      );
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );
}
