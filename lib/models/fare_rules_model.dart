class FareRulesModel {
  final int baseFare;
  final TripClass perKmRate;
  final TripClass perMinuteRate;
  final TripClass minimumFare;
  final String currency;

  FareRulesModel({
    required this.baseFare,
    required this.perKmRate,
    required this.perMinuteRate,
    required this.minimumFare,
    required this.currency,
  });

  factory FareRulesModel.fromJson(Map<String, dynamic> json) => FareRulesModel(
        baseFare: json["base_fare"],
        perKmRate: TripClass.fromJson(json["per_km_rate"]),
        perMinuteRate: TripClass.fromJson(json["per_minute_rate"]),
        minimumFare: TripClass.fromJson(json["minimum_fare"]),
        currency: json["currency"],
      );
}

class TripClass {
  final double economy;
  final double comfort;
  final double premium;

  TripClass({
    required this.economy,
    required this.comfort,
    required this.premium,
  });

  factory TripClass.fromJson(Map<String, dynamic> json) => TripClass(
        economy: json["Economy"]?.toDouble(),
        comfort: json["Comfort"]?.toDouble(),
        premium: json["Premium"]?.toDouble(),
      );
}
