import 'package:flutter/material.dart';

import '../../constants.dart';

class LocationMarker extends StatelessWidget {
  final bool start;
  const LocationMarker({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    // ColorScheme cs = Theme.of(context).colorScheme;
    // TextTheme tt = Theme.of(context).textTheme;

    return Icon(
      Icons.location_pin,
      color: start ? kStartLocationColor : kEndLocationColor,
      size: 70,
    );
  }
}
