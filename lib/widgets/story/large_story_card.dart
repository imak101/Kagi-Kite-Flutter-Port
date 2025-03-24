import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

class LargeStoryCard extends StatelessWidget {
  const LargeStoryCard(this.storyDataCluster, {super.key});

  final KiteCategoryCluster storyDataCluster;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final hasImage = storyDataCluster.articles.first.imageUrl.isNotEmpty;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell( // use inkwell for visual feedback on card tap
        onTap: () => showStoryInModalBottomSheet(context, storyDataCluster),
        borderRadius: BorderRadius.circular(10),
        splashColor: colorScheme.onPrimary,
        child: SizedBox(
          height: hasImage? 535 : 470,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Visibility(
                    visible: hasImage, // some stories don't have an image
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              height: constraints.maxHeight / 2,
                              width: constraints.maxWidth,
                              fit: BoxFit.cover,
                              placeholder: (context, str) => Icon(Icons.image_outlined),
                              filterQuality: FilterQuality.none,
                              imageUrl: storyDataCluster.articles.first.imageUrl,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: ColoredBox(
                                color: colorScheme.secondaryContainer.withValues(alpha: 0.7),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    storyDataCluster.category,
                                    style: TextStyle(
                                      color: colorScheme.onSecondaryContainer
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: hasImage ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2) : const EdgeInsets.only(top: 32, left: 6, right: 6),
                    child: AutoSizeText(
                      storyDataCluster.title,
                      minFontSize: hasImage ? 20 : 30,
                      maxLines: hasImage ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !hasImage,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        storyDataCluster.category,
                        style: TextStyle(
                          fontSize: 20,
                          color: colorScheme.secondary
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Align(
                        child: AutoSizeText(
                          storyDataCluster.shortSummary,
                          maxLines: hasImage ? 9 : 10,
                          minFontSize: hasImage ? 13: 17,
                          maxFontSize: hasImage ? 15 : 20,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorScheme.secondary
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
