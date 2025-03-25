import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/category/compact_category_view.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';

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
        if (categoriesSnapshot.hasError && categoriesSnapshot.connectionState == ConnectionState.done) {
          return RetryableNetworkErrorView(
            errorMessage: 'An error occurred while fetching today\'s articles',
            onRetry: () => setState(() {}), // force futurebuilder to refresh
          );
        }

        if (!categoriesSnapshot.hasData || categoriesSnapshot.connectionState != ConnectionState.done) {
          return Center(child: const CircularProgressIndicator());
        }

        final defaultCategories = ['World', 'Business', 'Technology', 'Science', 'Sports']; // these are the default categories that are shown on the kite website
        final shallowCategories = categoriesSnapshot.data!.shallowCategories.where((c) => defaultCategories.any((defCat) => c.name == defCat)).toList();

        return RefreshIndicator(
          onRefresh: () async {
            showNextKiteApiUpdateDialog(context);
            setState(() {});
          },
          child: ListView.builder(
            itemCount: shallowCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CompactCategoryView(shallowCategories[index]),
              );
            },
          ),
        );
      },
    );
  }
}
