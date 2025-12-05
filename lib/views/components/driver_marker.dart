import 'package:flutter/material.dart';
import 'package:taxi_booking_app/models/driver_model.dart';

class DriverMarker extends StatelessWidget {
  final DriverModel driver;
  const DriverMarker({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    // TextTheme tt = Theme.of(context).textTheme;

    return CircleAvatar(
      backgroundColor: cs.primary,
      radius: 50,
      child: Icon(
        Icons.directions_car,
        color: cs.onPrimary,
        size: 70,
      ),
    );
  }
}
