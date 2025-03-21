import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

void showStoryInModalBottomSheet(BuildContext context, KiteCategoryCluster story) {
  final colorScheme = ColorScheme.of(context);
  showModalBottomSheet(
    context: context,
    useRootNavigator: true, // show modal over the scaffold's bottom nav bar
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // the DraggableScrollableSheet will override the provided bottom sheet so hide it
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.93,
        child: DraggableScrollableSheet( // DraggableScrollableSheet for more control over the scrolling behavior with the sheet
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.75,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0))
              ),
              child: Column(
                children: [
                  Padding( // build a custom scrim because the DraggableScrollableSheet overrides the default bottom sheet and its scrim
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        borderRadius: const BorderRadius.all(Radius.circular(16))
                      ),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: StoryView(story, scrollController: controller),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  );
}

class StoryView extends StatelessWidget {
  const StoryView(this.storyDataCluster, {super.key, this.scrollController});

  final KiteCategoryCluster storyDataCluster;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    // map for shown widgets. if the map value is true, show widget, padding will be applied later.
    // one of the least verbose ways of defining the layout. easy to filter out widgets with no data and programmatically add padding, etc. to each widget.
    final storyWidgets = <Widget, bool>{
      StoryTitleView(storyDataCluster.title): true,
      StorySummaryView(storyDataCluster.shortSummary): true,
      StoryLocationView(storyDataCluster.location): storyDataCluster.location.isNotEmpty,

      Align(child: CaptionedPictureView(storyDataCluster.articles.first)): storyDataCluster.articles.first.imageUrl.isNotEmpty, // stories always have at least one article so we don't need to check for null. Align in case image width is very small

      TalkingPointsView(storyDataCluster.talkingPoints): storyDataCluster.talkingPoints.isNotEmpty,

      StoryQuoteCard(storyDataCluster.quote): storyDataCluster.quote.text.isNotEmpty,

      Align(child: CaptionedPictureView(storyDataCluster.articles[1])): storyDataCluster.articles.elementAtOrNull(1)?.imageUrl.isNotEmpty ?? false,

      PerspectivesView(storyDataCluster.perspectives): storyDataCluster.perspectives.isNotEmpty,

      TitledTextView('Historical Background', storyDataCluster.historicalBackground): storyDataCluster.historicalBackground.isNotEmpty,
      TitledBulletPointsView('Scientific Significance', storyDataCluster.scientificSignificance): storyDataCluster.scientificSignificance.isNotEmpty,
      TitledBulletPointsView('Technical Details', storyDataCluster.technicalDetails): storyDataCluster.technicalDetails.isNotEmpty,

      // the api needs to be more consistent with typing. there should only be 'businessAnglePoints' and an array with one item, not a separate string for just one item
      TitledTextView('Business Angle', storyDataCluster.businessAngleText): storyDataCluster.businessAngleText.isNotEmpty,
      TitledBulletPointsView('Business Angle', storyDataCluster.businessAnglePoints): storyDataCluster.businessAnglePoints.isNotEmpty,

      TitledBulletPointsView('User Experience Impact', storyDataCluster.userExperienceImpact): storyDataCluster.userExperienceImpact.isNotEmpty,
      TitledBulletPointsView('Gameplay Mechanics', storyDataCluster.gameplayMechanics): storyDataCluster.userExperienceImpact.isNotEmpty,
      TitledBulletPointsView('Performance Statistics', storyDataCluster.performanceStatistics): storyDataCluster.performanceStatistics.isNotEmpty,
      TitledTextView('League Standings', storyDataCluster.leagueStandings): storyDataCluster.leagueStandings.isNotEmpty,
      TitledBulletPointsView('Travel Advisory', storyDataCluster.travelAdvisory): storyDataCluster.travelAdvisory.isNotEmpty,
      TitledBulletPointsView('International Reaction', storyDataCluster.internationalReactions, showBullet: false, showDivider: true): storyDataCluster.internationalReactions.isNotEmpty,

      TimelineCard(storyDataCluster.timeline): storyDataCluster.timeline.isNotEmpty,

      StorySourcesView(articles: storyDataCluster.articles, publishers: storyDataCluster.publishers): true, // a story will always have sources
      
      ColoredTitledTextCard.points('Action Items', storyDataCluster.userActionItems, ColorScheme.fromSeed(seedColor: Colors.green)): storyDataCluster.userActionItems.isNotEmpty,
      ColoredTitledTextCard.body('Did You Know?', storyDataCluster.didYouKnow, ColorScheme.fromSeed(seedColor: Colors.blue)): storyDataCluster.didYouKnow.isNotEmpty,

      Center(child: (FilledButton(child: Text('Close Story'), onPressed: () => {context.pop()}))): true
    };

    storyWidgets.removeWhere((widget, isVisible) => isVisible == false);

    return ListView.builder(
      controller: scrollController,
      itemCount: storyWidgets.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: storyWidgets.keys.elementAt(index),
        );
      },
    );
  }
}