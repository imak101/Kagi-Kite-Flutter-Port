import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/on_this_day/widgets.dart';

class OnThisDayEventsTimelineView extends StatelessWidget {
  const OnThisDayEventsTimelineView(this.events, {super.key, this.eventFontSize});

  final List<KiteHistoricalEvent> events;
  final double? eventFontSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column( // refactor may be needed to improve readability; TimelineNodeTitle and TimelineConnectorText?
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: events.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
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
                              color: colorScheme.primary
                          ),
                        ),
                      ),
                      Text(
                        events[index].year,
                        style: TextStyle(
                          fontSize: (eventFontSize ?? 15) + 4,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary
                        ),
                      )
                    ],
                  ),
                  IntrinsicHeight( // use intrinsicheight so the connector rod is is as tall as the text which expands.
                    child: Row( // this row is for the 'connector' and the timeline event text. e.g "| *text*"
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 0),
                          child: Visibility(
                            visible: !isLastItem,
                            child: VerticalDivider(
                              width: 2,
                              thickness: 2,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: HistoricalEventHtmlView(
                              events[index].content,
                              fontSize: eventFontSize,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}