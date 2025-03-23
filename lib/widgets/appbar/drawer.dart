import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/appbar/title.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';

class KiteDrawerView extends StatelessWidget {
  const KiteDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: KiteTitleView(showDate: false),
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
                    titleTextStyle: TextStyle(fontSize: 18),
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
        Align(
          alignment: Alignment.centerRight,
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
