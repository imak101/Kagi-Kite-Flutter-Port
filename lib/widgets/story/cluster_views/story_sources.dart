import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StorySourcesView extends StatefulWidget {
  const StorySourcesView({required this.articles, required this.publishers, super.key});

  final List<KiteArticle> articles;
  final List<KitePublisher> publishers;

  @override
  State<StorySourcesView> createState() => _StorySourcesViewState();
}

class _StorySourcesViewState extends State<StorySourcesView> {
  late final List<_StorySource> _sources;
  bool _isVisible = false; // sources hidden by default to save space

  /// toggle visibility for the box that contains buttons with source info
  void _toggleIsVisible() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _sources = <_StorySource>[];
    for (final publisher in widget.publishers) { // populate data only once filtering it is not supported
      _sources.add(
          _StorySource(
            domainName: publisher.name,
            faviconUrl: publisher.faviconUrl,
            domainArticles: widget.articles.where((a) => a.domain == publisher.name).toList(),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector( // allow whole card to be tappable, maybe remove icon button and just the use the gesture detector?
          onTap: () => _toggleIsVisible(),
          child: Card(
            color: colorScheme.errorContainer, // use error color because it's bold (usually a shade of red) and stands out from other data widgets
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StorySubtitleView('Sources', color: colorScheme.onErrorContainer, includeBottomPadding: false),
                  IconButton(
                    icon: Animate( // rotate 180deg whenever tapped
                      effects: [RotateEffect(begin: 0, end: 0.5, duration: 200.milliseconds)],
                      target: _isVisible ? 1 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                    onPressed: () => _toggleIsVisible()
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: List<Widget>.generate(
                  _sources.length,
                  (index) => StorySourceButton(_sources[index])
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


@immutable
class _StorySource {
  const _StorySource({required this.domainName, required this.domainArticles, required this.faviconUrl});

  final String domainName;
  final List<KiteArticle> domainArticles;
  final String faviconUrl;
}

@visibleForTesting // would be private otherwise
class StorySourceButton extends StatelessWidget {
  const StorySourceButton(this.source, {super.key});

  final _StorySource source;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(source.domainName),
            Text(
              '${source.domainArticles.length} articles',
              style: TextStyle(
                fontSize: 11
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (source.domainArticles.length == 1) {
          launchUrlString(source.domainArticles.first.link);
          return;
        }
        _showAllSourcesDialog(context, source.domainName, source.domainArticles);
      },
      icon: source.faviconUrl.isEmpty ? SizedBox.shrink() : CachedNetworkImage(imageUrl: source.faviconUrl),
    );
  }
}

_showAllSourcesDialog(BuildContext context, String domainName, List<KiteArticle> sources) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text('Articles from $domainName'),
      content: SingleChildScrollView(
        child: Wrap(
          children: List.generate(
            sources.length,
            (index) => ListTile(
              title: Text(sources[index].title),
              trailing: Icon(Icons.chevron_right),
              onTap: () => launchUrlString(sources[index].link),
            )
          ),
        ),
      ),
      actions: [
        TextButton( // todo: add 'view source background' button
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    );
  });
}