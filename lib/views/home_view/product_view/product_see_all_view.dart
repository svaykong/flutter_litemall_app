import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../utils/util.dart';

class ProductSeeAllView extends StatelessWidget {
  const ProductSeeAllView({
    Key? key,
    required this.seeAll,
    required this.data,
  }) : super(key: key);

  final String seeAll;
  final List<ProductSubData> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All $seeAll',
          style: const TextStyle(
            color: Global.thirdColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: CardGridView(
          data: data,
          productType: 'product_see_all_view',
          // newHero: newHero,
        ),
      ),
    );
  }
}
