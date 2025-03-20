import 'package:flutter/material.dart';

/// Automatically pads text with 2 on the bottom
class StorySubtitleView extends StatelessWidget {
  const StorySubtitleView(this.text, {super.key, this.color, this.includeBottomPadding = true});

  final String text;
  final Color? color;
  final bool includeBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: includeBottomPadding ? 2 : 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
