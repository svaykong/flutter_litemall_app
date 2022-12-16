import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../viewmodels/viewmodel.dart';
import '../../../../utils/util.dart';

class ShoeView extends StatelessWidget {
  const ShoeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, productViewModel, _) {
        final shoes = productViewModel.shoes;

        if (shoes.isEmpty) {
          return const Text(
            'Shoes not available',
            style: TextStyle(fontSize: 24),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: CardGridView(
            data: shoes,
            productType: 'product_see_all_shoes',
          ),
        );
      },
    );
  }
}
