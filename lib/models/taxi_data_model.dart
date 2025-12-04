import 'driver_model.dart';
import 'fare_rules_model.dart';

class TaxiDataModel {
  final List<DriverModel> drivers;
  final FareRulesModel fareRules;

  TaxiDataModel({
    required this.drivers,
    required this.fareRules,
  });

  factory TaxiDataModel.fromJson(Map<String, dynamic> json) => TaxiDataModel(
        drivers: List<DriverModel>.from(json["drivers"].map((x) => DriverModel.fromJson(x))),
        fareRules: FareRulesModel.fromJson(json["fare_rules"]),
      );
}
