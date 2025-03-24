import 'package:flutter/material.dart';

class WikipediaText extends StatelessWidget {
  const WikipediaText(this.text, {super.key, this.colorScheme, this.isBold = false, this.fontSize});

  final String text;
  final ColorScheme? colorScheme;
  final bool isBold;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final color = colorScheme ?? ColorScheme.of(context);

    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.primary,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          fontSize: fontSize
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(
                color: color.primary,
                child: Padding(
                  padding: const EdgeInsets.all(0.3),
                  child: Image.asset(
                    'assets/images/wikipedia_logo.transparent.png',
                    color: color.onPrimary,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            )
          )
        ]
      ),
    );
  }
}
