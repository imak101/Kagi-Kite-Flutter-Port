import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';
import 'package:kagi_kite_demo/widgets/story/cluster_views/story_subtitle.dart';

class StoryQuoteCard extends StatelessWidget {
  const StoryQuoteCard(this.quote, {super.key});
  
  final KiteQuote quote;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StorySubtitleView('Quote'),
        Card(
          margin: EdgeInsets.zero,
          color: colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    quote.text,
                    style: TextStyle(
                      color: colorScheme.onTertiaryContainer
                    ),
                  ),
                ),
                HyperlinkView(
                  text: '- ${quote.author} (via ${quote.sourceDomain})',
                  url: quote.sourceUrl,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
