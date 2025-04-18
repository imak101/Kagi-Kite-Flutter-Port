import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';
import 'package:wave_divider/wave_divider.dart';

class TalkingPointsView extends StatelessWidget {
  const TalkingPointsView(this.talkingPoints, {super.key});

  final List<String> talkingPoints;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StorySubtitleView('Highlights'), // this section is listed as "highlights" on the website
        Card(
          color: colorScheme.secondaryContainer,
          margin: EdgeInsets.zero,
          elevation: 2,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            itemCount: talkingPoints.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var splitTalkingPoint = talkingPoints[index].replaceFirst(':', '*firstColon*').split('*firstColon*'); // talking point title and text delimited by ":". sometimes the item contains more than one colon in it. insert special value where the fist colon is then split.

              if (splitTalkingPoint.length != 2) { // the talking point is malformed. there should only be two strings in a properly formatted point. 'title: content'
                splitTalkingPoint = ['Error', 'There was an error while processing this point.'];
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(index + 1).toString()}. ${splitTalkingPoint.first.trim()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSecondaryContainer
                      ),
                    ),
                    Text(
                      splitTalkingPoint.last.trim(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (index + 1 != talkingPoints.length)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: WaveDivider(
                          thickness: 2,
                        ),
                      )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
