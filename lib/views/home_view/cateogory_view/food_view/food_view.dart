import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../utils/util.dart';
import '../../../../viewmodels/viewmodel.dart';

class FoodView extends StatelessWidget {
  const FoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, _) {
          final foods = productViewModel.foods;

          if (foods.isEmpty) {
            return const Text(
              'Foods not available',
              style: TextStyle(fontSize: 24),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: CardGridView(
              data: foods,
              productType: 'product_see_all_view_foods',
            ),
          );
        },
      ),
    );
  }
}
