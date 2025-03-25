import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/appbar/title.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';


class KiteDrawerView extends StatelessWidget {
  const KiteDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: KiteTitleView(showDate: false),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IconButton(
                  onPressed: () async {
                    final info = await PackageInfo.fromPlatform();
                    if (!context.mounted) return;
                    showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset('assets/icon/icon.png', width: 35, height: 35),
                      applicationVersion: '${info.version}+${info.buildNumber}',
                      children: [
                        Center(
                          child: FilledButton(
                            onPressed: () => launchUrlString('https://github.com/imak101/kite_flutter_port'),
                            child: Text('View on Github'),
                          ),
                        )
                      ]
                    );
                  },
                  icon: Icon(Icons.info_outline),
                ),
              )
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: FutureBuilder(
            future: GetIt.I<KiteApiClient>.call().getAllShallowCategories(),
            builder: (context, categoriesSnapshot) {
              if (!categoriesSnapshot.hasData) {
                return Center(child: const CircularProgressIndicator());
              }
          
              final shallowCategories = categoriesSnapshot.data!.shallowCategories.where((c) => c.name != 'OnThisDay').toList();
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: shallowCategories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    visualDensity: VisualDensity.comfortable,
                    trailing: Icon(Icons.chevron_right),
                    title: Text(shallowCategories[index].name),
                    titleTextStyle: TextStyle(fontSize: 18, color: colorScheme.onSurfaceVariant),
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      context.go('/feed/categoryDetail', extra: shallowCategories[index]);
                    },
                  );
                },
              );
            },
          ),
        ),
        Divider(
          height: 0,
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: HyperlinkView(
              text: 'visit kite.kagi.com',
              url: 'https://kite.kagi.com/',
            ),
          ),
        )
      ],
    );
  }
}
