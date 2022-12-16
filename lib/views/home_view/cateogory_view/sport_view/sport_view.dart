import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../utils/util.dart';
import '../../../../viewmodels/viewmodel.dart';

class SportView extends StatelessWidget {
  const SportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, _) {
          final sports = productViewModel.sports;

          if (sports.isEmpty) {
            return const Text(
              'Sports not available',
              style: TextStyle(fontSize: 24),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: CardGridView(data: sports,
            productType: 'product_see_all_view_sport',
            ),
          );
        },
      ),
    );
  }
}
