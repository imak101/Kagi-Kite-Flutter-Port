import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HistoricalEventHtmlView extends StatelessWidget {
  const HistoricalEventHtmlView(this.htmlContent, {super.key, this.colorScheme, this.fontSize});

  final String htmlContent;
  final ColorScheme? colorScheme;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlContent.replaceAll('(pictured)', ''),
      textStyle: TextStyle(fontSize: fontSize),
      customWidgetBuilder: (element) {
        if (element.localName != 'a') return null; // we only want to decorate anchor tags

        return InlineCustomWidget(
          child: GestureDetector(
            onTap: () => launchUrlString(element.attributes['href']!), // all <a> tags have an href.
            child: WikipediaText(
              element.text,
              colorScheme: colorScheme,
              isBold: element.parent?.localName == 'b',
              fontSize: fontSize,
            ),
          ),
        );
      },
    );
  }
}
