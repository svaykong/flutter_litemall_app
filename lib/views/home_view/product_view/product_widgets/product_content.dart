import 'package:flutter/material.dart';

import '../product_see_all_view.dart';
import '../product_view.dart';
import '../../../../models/product_model.dart';
import '../../../../utils/util.dart';

class ProductContent extends StatefulWidget {
  const ProductContent({
    Key? key,
    required this.data,
    required this.productType,
  }) : super(key: key);

  final List<ProductSubData> data;
  final String productType;

  @override
  State<ProductContent> createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  List<ProductSubData> _listProducts = [];
  String value = '';

  void _init() {
    _listProducts = widget.data;

    bool check1 = _listProducts.first.attributes.isFeaturedProduct;
    bool check2 = _listProducts.first.attributes.isBestSeller;
    bool check3 = _listProducts.first.attributes.isNewArrival;
    bool check4 = _listProducts.first.attributes.isTopRatedProduct;
    bool check5 = _listProducts.first.attributes.isSpecialOffer;

    if (check1) {
      value = 'Featured Product';
    } else if (check2) {
      value = 'Best Sellers';
    } else if (check3) {
      value = 'New Arrivals';
    } else if (check4) {
      value = 'Top Rated Product';
    } else if (check5) {
      value = 'Special Offers';
    }
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleShowCase(
          text1: value,
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductSeeAllView(
                  seeAll: value,
                  data: _listProducts,
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _listProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  width: width * 0.4,
                  child: ProductView(
                    productType: widget.productType,
                    data: _listProducts[index],
                    onProductUpdate: () {
                      'onProductUpdate...'.log();
                      setState(() {
                        _listProducts.remove(_listProducts[index]);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: height * 0.25,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: _listProducts.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: SizedBox(
//                   width: width * 0.4,
//                   child: ProductView(
//                     data: _listProducts[index],
//                     // newHero: widget.newHero,
//                     onProductUpdate: () {
//                       'onProductUpdate...'.log();
//                       setState(() {
//                         _listProducts.remove(_listProducts[index]);
//                       });
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     )
