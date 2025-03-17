import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/compact_story_card.dart';

class CompactCategoryView extends StatelessWidget {
  const CompactCategoryView(this.shallowCategory, {super.key});

  final ShallowKiteCategory shallowCategory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Text(
              shallowCategory.name,
              style: TextStyle(
                  fontSize: 25,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, size: 33, color: colorScheme.secondary),
          ],
        ),
        FutureBuilder(
          future: GetIt.I<KiteApiClient>.call().getCategory(shallowCategory),
          builder: (context, categorySnapshot) {
            if (!categorySnapshot.hasData) {
              return SizedBox(
                height: 200,
                child: Center(child: const CircularProgressIndicator()),
              );
            }

            final storyClusters = categorySnapshot.data!.dataClusters;
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: storyClusters.length,
                prototypeItem: Card(child: SizedBox(width: 200,height: 200)),
                cacheExtent: 9999, // high cache extent to avoid constant redraws on cards as the list is scrolled
                itemBuilder: (context, index) {
                  return CompactStoryCard(storyClusters[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
