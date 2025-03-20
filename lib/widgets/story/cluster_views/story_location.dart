import 'package:flutter/material.dart';

/// Formats a story's location with an appropriate icon
class StoryLocationView extends StatelessWidget {
  const StoryLocationView(this.location, {super.key});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            Icons.location_on_outlined,
            size: 22,
          ),
        ),
        Text(
          location,
          style: TextStyle(
            fontSize: 13
          ),
        )
      ],
    );
  }
}
