import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/viewmodel.dart';
import 'product_view/product_widgets/product_content.dart';

class ProductsShowCase extends StatelessWidget {
  const ProductsShowCase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.read<ProductViewModel>();
    return Column(
      children: [
        // Featured Product showcase
        productViewModel.featuredPro.isNotEmpty ? ProductContent(productType: 'feature', data: productViewModel.featuredPro) : const SizedBox.shrink(),

        // Best Sellers showcase
        productViewModel.bestSellerPro.isNotEmpty ? ProductContent(productType: 'bestSeller', data: productViewModel.bestSellerPro) : const SizedBox.shrink(),

        // New Arrivals showcase
        productViewModel.newArrivalPro.isNotEmpty ? ProductContent(productType: 'newArrival', data: productViewModel.newArrivalPro) : const SizedBox.shrink(),

        // Top Rated Product showcase
        productViewModel.topRatedPro.isNotEmpty ? ProductContent(productType: 'topRated', data: productViewModel.topRatedPro) : const SizedBox.shrink(),

        // Top Rated Product showcase
        productViewModel.specialOfferPro.isNotEmpty
            ? ProductContent(productType: 'specialOffer', data: productViewModel.specialOfferPro)
            : const SizedBox.shrink(),
      ],
    );
  }
}
