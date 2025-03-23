import 'package:flutter/foundation.dart';

class LocationStringParser {
  const LocationStringParser(this.location);

  final String location;

  String launchableUriString() {
    return 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeQueryComponent(location)}';
  }
}