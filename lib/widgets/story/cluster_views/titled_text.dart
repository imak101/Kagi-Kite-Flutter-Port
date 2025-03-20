import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';
import 'package:wave_divider/wave_divider.dart';

/// Formats text with a bold title
class TitledTextView extends StatelessWidget {
  const TitledTextView(this.title, this.body, {super.key, this.textColor});

  final String title;
  final String body;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: textColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorySubtitleView(title, color: textColor),
        Text(body, style: textStyle),
      ],
    );
  }
}

// Formats a list of strings with a bold title, optional bullet points and an optional divider
class TitledBulletPointsView extends StatelessWidget {
  const TitledBulletPointsView(this.title, this.points, {super.key, this.showDivider = false, this.showBullet = true, this.textColor});

  final String title;
  final List<String> points;

  final bool showDivider;
  final bool showBullet;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: textColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorySubtitleView(title, color: textColor),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: points.length,
          itemBuilder: (context, index) {
            final isLastItem = index + 1 == points.length;

            return Padding(
              padding: EdgeInsets.only(bottom: isLastItem ? 0 : 4), // do not pad last item in the list
              child: Column(
                children: [
                  Text('${showBullet ? '• ' : ''}${points[index]}', style: textStyle),
                  if (showDivider && !isLastItem) WaveDivider(thickness: 2, color: textColor)
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}


class ColoredTitledTextCard extends StatelessWidget {
  const ColoredTitledTextCard._({super.key, required this.title, this.body, this.points, required this.colorScheme});

  // not using formal parameter because we want a non-null value here
  const ColoredTitledTextCard.body(this.title, String body, this.colorScheme, {super.key})
  : body = body, points = null;

  const ColoredTitledTextCard.points(this.title, List<String> points, this.colorScheme, {super.key})
  : points = points, body = null;

  final String title;
  final String? body;
  final List<String>? points;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: body == null ?
          TitledBulletPointsView(title, points!, textColor: colorScheme.onPrimary)
          : TitledTextView(title, body!, textColor: colorScheme.onPrimary),
      ),
    );
  }
}
