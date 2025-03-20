import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/category/compact_category_view.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<KiteApiClient>.call().getAllShallowCategories(),
      builder: (context, categoriesSnapshot) {
        if (!categoriesSnapshot.hasData) {
          return Center(child: const CircularProgressIndicator());
        }
        // filter the "On This Day" category as that will be shown in a different page
        // final shallowCategories = categoriesSnapshot.data!.shallowCategories.where((c) => c.name != "OnThisDay").toList();
        
        final shallowCategories = categoriesSnapshot.data!.shallowCategories.where((c) => c.name != "OnThisDay").take(10).toList();

        return ListView.builder(
          itemCount: shallowCategories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CompactCategoryView(shallowCategories[index]),
            );
          },
        );
      },
    );
  }
}
