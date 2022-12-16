import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../utils/util.dart';
import '../../../../viewmodels/viewmodel.dart';

class ComputerView extends StatelessWidget {
  const ComputerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ProductViewModel>(
        builder: (context, productViewModel, _) {
          final computers = productViewModel.computers;

          if (computers.isEmpty) {
            return const Text(
              'Computers not available',
              style: TextStyle(fontSize: 24),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: CardGridView(
              data: computers,
              productType: 'product_see_all_view_computer',
            ),
          );
        },
      ),
    );
  }
}
