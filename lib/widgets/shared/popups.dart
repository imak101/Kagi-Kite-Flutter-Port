import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';

showNextKiteApiUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Kite is Different', textAlign: TextAlign.center),
        content: Text('Kite only updates once a day, around ${DateTime.utc(2025, 1, 1, 13, 0, 0).toLocal().format('ga T')} (noon UTC).', textAlign: TextAlign.center), // format noon utc to local timezone. the .format('ga T') looks like '6am MST'
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      );
    }
  );
}