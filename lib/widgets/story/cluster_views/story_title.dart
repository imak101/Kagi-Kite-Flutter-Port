import 'package:flutter/material.dart';

class StoryTitleView extends StatelessWidget {
  const StoryTitleView(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: colorScheme.primary,
        fontWeight: FontWeight.w800
      ),
    );
  }
}
