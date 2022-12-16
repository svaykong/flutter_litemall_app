import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../viewmodels/viewmodel.dart';
import '../../../../utils/util.dart';

class ClothView extends StatelessWidget {
  const ClothView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, _) {
          final clothes = productViewModel.clothes;

          if (clothes.isEmpty) {
            return const Text(
              'Clothes not available',
              style: TextStyle(fontSize: 24),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: CardGridView(data: clothes, productType: 'product_see_all_view_clothes',),
          );
        },
      ),
    );
  }
}
