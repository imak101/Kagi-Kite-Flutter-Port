import 'package:flutter/material.dart';

class StorySummaryView extends StatelessWidget {
  const StorySummaryView(this.summary, {super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Text(
      summary,
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }
}
