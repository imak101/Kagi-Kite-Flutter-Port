import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';

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
        HyperlinkView(
          text: location,
          url: 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeQueryComponent(location)}', // maybe use platform-specific map?
          fontSize: 13,
        ),
      ],
    );
  }
}
