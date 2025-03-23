import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Clickable text. Text will be red if the url is invalid.
class HyperlinkView extends StatelessWidget {
  const HyperlinkView({super.key,required this.text, required this.url});

  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(url);
    final isUriValid = uri != null;

    final textColor = isUriValid ? Colors.lightBlue : Colors.red;

    return InkWell(
      onTap: () {
        if (!isUriValid) return;
        launchUrl(uri);
      },
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          decoration: TextDecoration.underline,
          decorationColor: textColor,
        ),
      ),
    );
  }
}
