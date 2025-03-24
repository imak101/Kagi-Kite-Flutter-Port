import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/services/network/wikipedia/wikipedia_api_client.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:kagi_kite_demo/widgets/on_this_day/widgets.dart';

class HistoricalPersonView extends StatelessWidget {
  const HistoricalPersonView(this.event, {super.key});

  final KiteHistoricalEvent event;

  @override
  Widget build(BuildContext context) {
    // parses the content html for the fist time a 'title' attribute appears after an anchor tag (<a).
    // this is actually less verbose than using html/parser and traversing the tree to find it, plus the kite website uses regex for this exact purpose.
    final wikiQuery = RegExp(r'<a[^>]*title=("[^"]+")').firstMatch(event.content)?.group(1)?.replaceAll('"', '');
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Visibility(
            visible: wikiQuery != null,
            child: FutureBuilder(
              future: GetIt.I<WikipediaApiClient>.call().getSummaryForQuery(wikiQuery!),
              builder: (context, wikiSnapshot) {
                if (!wikiSnapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                final wikiSummary = wikiSnapshot.data!;

                if (wikiSummary.thumbnailUrl == null || wikiSnapshot.hasError) {
                  return SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.image_not_supported_outlined),
                  );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageUrl: wikiSummary.thumbnailUrl!,
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: HistoricalEventHtmlView(
            event.content,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
