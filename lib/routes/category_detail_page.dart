import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/category/widgets.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage(this.shallowCategory, {super.key});

  final ShallowKiteCategory shallowCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FutureBuilder(
        future: GetIt.I<KiteApiClient>.call().getCategory(shallowCategory),
        builder: (context, categorySnapshot) {
          if (!categorySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryData = categorySnapshot.data!.dataClusters;
          return FullCategoryView(shallowCategory.name, categoryData);
        }
      ),
    );
  }
}