class FareRulesModel {
  final double baseFare;
  final CarType perKmRate;
  final CarType perMinuteRate;
  final CarType minimumFare;
  final String currency;

  FareRulesModel({
    required this.baseFare,
    required this.perKmRate,
    required this.perMinuteRate,
    required this.minimumFare,
    required this.currency,
  });

  factory FareRulesModel.fromJson(Map<String, dynamic> json) => FareRulesModel(
        baseFare: json["base_fare"]?.toDouble(),
        perKmRate: CarType.fromJson(json["per_km_rate"]),
        perMinuteRate: CarType.fromJson(json["per_minute_rate"]),
        minimumFare: CarType.fromJson(json["minimum_fare"]),
        currency: json["currency"],
      );
}

class CarType {
  final double economy;
  final double comfort;
  final double premium;

  CarType({
    required this.economy,
    required this.comfort,
    required this.premium,
  });

  factory CarType.fromJson(Map<String, dynamic> json) => CarType(
        economy: json["Economy"]?.toDouble(),
        comfort: json["Comfort"]?.toDouble(),
        premium: json["Premium"]?.toDouble(),
      );
}
