import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/widgets/story/cluster_views/story_subtitle.dart';

/// Expects the event String to be in the format of '*date*:: *event*'
class TimelineCard extends StatelessWidget {
  const TimelineCard(this.events, {super.key});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column( // refactor may be needed to improve readability; TimelineNodeTitle and TimelineConnectorText?
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorySubtitleView('Timeline'),
        Card(
          color: colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: events.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final splitEvent = events[index].split('::');
                final isLastItem = index == events.length - 1;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row( // this row is for the node and its title e.g. "⚪ *title*"
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.tertiary
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colorScheme.onTertiary
                                ),
                              )
                            ),
                          ),
                        ),
                        Text(
                          splitEvent.first.trim(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.tertiary
                          ),
                        )
                      ],
                    ),
                    Row( // this row is for the 'connector' and the timeline event text. e.g "| *text*"
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                          child: SizedBox(
                            height: 50,
                            child: Visibility(
                              visible: !isLastItem,
                              child: VerticalDivider(
                                width: 2,
                                thickness: 2,
                                color: colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: isLastItem ? 10.0 : 8.0, top: 8, bottom: 8), // left padding to account for not having the divider shown on the last item
                            child: AutoSizeText(
                              splitEvent.last.trim(),
                              maxLines: 2,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
