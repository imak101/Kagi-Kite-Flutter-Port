import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

class CompactStoryCard extends StatelessWidget {
  CompactStoryCard(this.storyDataCluster, {super.key, this.size = const Size(200,200)})
      : assert(size.height >= 200), assert(size.width >= 200);

  final KiteCategoryCluster storyDataCluster;
  final Size size; // support resizing of the card for future changes

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return GestureDetector(
      onTap: () => showStoryInModalBottomSheet(context, storyDataCluster),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: size.height,
          width: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: storyDataCluster.articles.first.imageUrl.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Visibility(
                visible: storyDataCluster.articles.first.imageUrl.isNotEmpty, // some stories don't have an image
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: size.height / 2,
                    width: size.width,
                    fit: BoxFit.cover,
                    placeholder: (context, str) => Icon(Icons.image_outlined),
                    filterQuality: FilterQuality.none,
                    imageUrl: storyDataCluster.articles.first.imageUrl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  storyDataCluster.category,
                  style: TextStyle(
                    fontSize: storyDataCluster.articles.first.imageUrl.isEmpty ? 14 : 11, // increase font size title text when there is no picture
                    color: colorScheme.secondary
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                child: AutoSizeText(
                  storyDataCluster.title,
                  minFontSize: storyDataCluster.articles.first.imageUrl.isEmpty ? 20 : 14,
                  maxLines: storyDataCluster.articles.first.imageUrl.isEmpty ? 4 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
