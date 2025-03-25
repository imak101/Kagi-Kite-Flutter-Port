import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/category/widgets.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage(this.shallowCategory, {super.key});

  final ShallowKiteCategory shallowCategory;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      color: colorScheme.surface, // without a background color, the 'back swipe' gesture on ios to pop the page looks buggy.
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: FutureBuilder(
          future: GetIt.I<KiteApiClient>.call().getCategory(widget.shallowCategory),
          builder: (context, categorySnapshot) {
            if (categorySnapshot.hasError && categorySnapshot.connectionState == ConnectionState.done) {
              return RetryableNetworkErrorView(
                errorMessage: 'An error occurred while fetching articles for ${widget.shallowCategory.name}',
                onRetry: () => setState(() {}), // force future builder to reload
              );
            }

            if (!categorySnapshot.hasData || categorySnapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final categoryData = categorySnapshot.data!.dataClusters;
            return FullCategoryView(widget.shallowCategory.name, categoryData);
          }
        ),
      ),
    );
  }
}