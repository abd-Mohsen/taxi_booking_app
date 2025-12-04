class VehicleModel {
  final String type;
  final String make;
  final String model;
  final int year;
  final String color;
  final String plateNumber;

  VehicleModel({
    required this.type,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        type: json["type"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        color: json["color"],
        plateNumber: json["plate_number"],
      );

  String fullName() {
    return "$make $model $year";
  }
}
