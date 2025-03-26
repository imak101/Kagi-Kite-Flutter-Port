import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kagi_kite_demo/widgets/story/widgets.dart';

import '../../../util.dart';


void main() {
  testWidgets('Test image and caption show with valid input', (tester) async {
    final sampleArticle = getSampleCategory().dataClusters.first.articles.first;

    await tester.pumpWidget(withApp(CaptionedPictureView(sampleArticle)));

    expect(find.byType(CachedNetworkImage), findsOne); // ensure finds image
    expect(find.text(sampleArticle.imageCaption), findsOne); // ensure finds caption
    expect(find.text(sampleArticle.domain), findsOne); // ensure finds domain stacked on picture
  });

  testWidgets('Test image shows without caption if KiteArticles caption is empty', (tester) async {
    final sampleArticle = getSampleCategory().dataClusters.first.articles.first.copyWith.call(imageCaption: '');

    await tester.pumpWidget(withApp(CaptionedPictureView(sampleArticle)));

    expect(sampleArticle.imageCaption, isEmpty);

    expect(find.byType(CachedNetworkImage), findsOne); // ensure finds image
    expect(find.byType(AutoSizeText), findsNothing); // ensure caption is not shown when string is empty;
    expect(find.text(sampleArticle.domain), findsOne); // ensure finds domain stacked on picture
  });
}
