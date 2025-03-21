import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

class FullCategoryView extends StatelessWidget {
  const FullCategoryView(this.categoryName, this.storyDataClusters, {super.key});

  final String categoryName;
  final List<KiteCategoryCluster> storyDataClusters;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.chevron_left,
                    size: 35,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 30,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 500) { // show grid layout if user has large screen
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  children: List<Widget>.generate(
                    storyDataClusters.length,
                    (index) => LargeStoryCard(storyDataClusters[index]),
                  ),
                );
              }
          
              return ListView.builder(
                itemCount: storyDataClusters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: LargeStoryCard(storyDataClusters[index]),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
