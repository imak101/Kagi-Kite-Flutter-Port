import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';
import 'package:kagi_kite_demo/widgets/story/cluster_views/story_subtitle.dart';

_showModalPerspective(BuildContext context, String perspectiveTitle, String perspectiveText) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(perspectiveTitle),
          content: Text(perspectiveText),
          actions: [
            TextButton(
                onPressed: () => context.pop(),
                child: const Text('Close'))
          ],
        );
      }
  );
}

class PerspectivesView extends StatelessWidget {
  const PerspectivesView(this.perspectives, {super.key});

  final List<KitePerspective> perspectives;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorySubtitleView('Perspectives'),
        SizedBox(
          height: 250, // should be fixed height and width; mimics website
          child: ListView.builder(
            itemCount: perspectives.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final splitPerspective = perspectives[index].text.split(':'); // the api delimits the perspective owner and text with ':'

              return Card(
                color: colorScheme.primaryContainer,
                child: SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AutoSizeText(
                          splitPerspective.first.trim(),
                          minFontSize: 13,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onPrimaryContainer
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            splitPerspective.last.trim(),
                            minFontSize: 12,
                            maxLines: 9,
                            style: TextStyle(
                              fontSize: 14
                            ),
                            overflowReplacement: Center( // if text overflows and won't fit in box even with smallest font size
                              child: FilledButton(
                                child: Text('View'),
                                onPressed: () {
                                  _showModalPerspective(context, splitPerspective.first.trim(), splitPerspective.last.trim());
                                },
                              ),
                            ),
                          ),
                        ),
                        HyperlinkView(
                          text: perspectives[index].sources.first.name,
                          url: perspectives[index].sources.first.url,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
