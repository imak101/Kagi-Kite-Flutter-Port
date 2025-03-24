import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/on_this_day/widgets.dart';

class PeopleCarouselView extends StatelessWidget {
  const PeopleCarouselView(this.events, {super.key});

  final List<KiteHistoricalEvent> events;

  @override
  Widget build(BuildContext context) {
    return CarouselView.weighted(
      flexWeights: [2, 7, 2],
      backgroundColor: ColorScheme.of(context).primaryContainer,
      itemSnapping: true,
      enableSplash: false,
      elevation: 2,
      children: List.generate(events.length, (index) =>
        OverflowBox(
          minWidth: 249,
          maxWidth: 250,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  events[index].year,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Expanded(
                  child: HistoricalPersonView(events[index])
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
