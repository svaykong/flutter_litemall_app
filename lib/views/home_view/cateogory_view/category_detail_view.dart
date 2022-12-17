import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'cloth_view/cloth_view.dart';
import 'shoe_view/shoe_view.dart';
import 'food_view/food_view.dart';
import 'sport_view/sport_view.dart';
import 'computer_view/computer_view.dart';
import '../../../utils/util.dart';
import '../../../models/category_model.dart';
import '../../../viewmodels/product_viewmodel/product_viewmodel.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Data data;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ToastContext().init(context);
    final productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(color: Global.thirdColor),
        ),
        centerTitle: true,
        actions: [
          StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return CustomIconButton(
                onPressed: () => Navigator.of(context).pushNamed(Global.CART).then((value) => setState(() {})),
                icon: CustomIcon.cart,
                showBadge: productViewModel.cartLists.isNotEmpty ? true : false,
              );
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30, bottom: 20.0),
              child: Text(
                data.attributes.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: SearchPlaceholder(
                onTap: () => Toast.show('Currently search is not available...', duration: 3, gravity: Toast.top),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.6,
                child: _renderSubCategory(context: context, name: data.attributes.title),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Global.firstColor,
                  side: const BorderSide(width: 1.0),
                  fixedSize: Size(width * 0.8, height * 0.045),
                ),
                onPressed: () {
                  'Filter & Sorting pressed ...'.log();
                  Toast.show('Currently filter is not available...', duration: 3, gravity: Toast.top);
                },
                child: const Text(
                  'Filter & Sorting',
                  style: TextStyle(
                    color: Global.thirdColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderSubCategory({required BuildContext context, required String name}) {
    switch (name.toLowerCase()) {
      case 'shoes':
        return const ShoeView();
      case 'clothes':
        return const ClothView();
      case 'foods':
        return const FoodView();
      case 'sport':
        return const SportView();
      case 'computer':
        return const ComputerView();
      default:
        return const SizedBox.shrink();
    }
  }
}
