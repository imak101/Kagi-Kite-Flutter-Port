import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/on_this_day/widgets.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';

class OnThisDayPage extends StatefulWidget {
  const OnThisDayPage({super.key});

  @override
  State<OnThisDayPage> createState() => _OnThisDayPageState();
}

class _OnThisDayPageState extends State<OnThisDayPage> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final titleTextStyle = TextStyle(
        fontSize: 25,
        color: colorScheme.primary,
        fontWeight: FontWeight.w600
    );

    return FutureBuilder(
      future: GetIt.I<KiteApiClient>.call().getOnThisDay(),
      builder: (context, onThisDaySnapshot) {
        if (onThisDaySnapshot.hasError && onThisDaySnapshot.connectionState == ConnectionState.done) {
          return RetryableNetworkErrorView(
            errorMessage: 'An error occurred while fetching today\'s events',
            onRetry: () => setState(() {}), // force future builder to reload
          );
        }

        if (!onThisDaySnapshot.hasData || onThisDaySnapshot.connectionState != ConnectionState.done) {
          return Center(child: const CircularProgressIndicator());
        }

        final onThisDay = onThisDaySnapshot.data!;
        return RefreshIndicator(
          onRefresh: () async {
            showNextKiteApiUpdateDialog(context);
            setState(() {}); // force future builder to reload
          },
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.landscape) {
                return Padding( // support landscape device orientation view
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Events',
                                style: titleTextStyle,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OnThisDayEventsTimelineView(
                                    onThisDay.historicalEvents,
                                    eventFontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'People',
                                style: titleTextStyle,
                              ),
                            ),
                            Expanded(
                              child: PeopleCarouselView(onThisDay.people),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Events',
                      style: titleTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OnThisDayEventsTimelineView(
                          onThisDay.historicalEvents,
                          eventFontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'People',
                      style: titleTextStyle,
                    ),
                  ),
                  Expanded(
                    child: PeopleCarouselView(onThisDay.people),
                  ),
                ],
              );
            }
          ),
        );
      },
    );
  }
}