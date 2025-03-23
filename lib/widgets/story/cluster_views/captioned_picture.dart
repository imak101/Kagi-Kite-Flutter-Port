import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CaptionedPictureView extends StatelessWidget {
  const CaptionedPictureView(this.article, {super.key});

  final KiteArticle article;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                placeholder: (context, url) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Icon(Icons.image_outlined),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.7),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(article.domain, style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  splashColor: colorScheme.primary,
                  onTap: () => launchUrlString(article.link),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: article.imageCaption.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: AutoSizeText(
              article.imageCaption,
              maxFontSize: 12,
              style: TextStyle(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        ),
      ],
    );
  }
}
