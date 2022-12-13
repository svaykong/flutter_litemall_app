import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';
import '../product_see_all_view.dart';
import '../product_view.dart';
import '../../../../utils/util.dart';

class ProductContent extends StatelessWidget {
  const ProductContent({
    Key? key,
    required this.data,
    this.newHero = false,
  }) : super(key: key);

  final List<ProductSubData> data;
  final bool newHero;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool check1 = data.first.attributes.isFeaturedProduct;
    bool check2 = data.first.attributes.isBestSeller;
    bool check3 = data.first.attributes.isNewArrival;
    bool check4 = data.first.attributes.isTopRatedProduct;
    bool check5 = data.first.attributes.isSpecialOffer;

    String value = '';
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

    return newHero
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: SizedBox(
                        width: width * 0.4,
                        child: ProductView(
                          data: data[index],
                          newHero: newHero,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleShowCase(
                text1: value,
                onPressed: () async {
                  '$value See All pressed -- newHero -- $newHero ...'.log();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductSeeAllView(
                        seeAll: value,
                        data: data,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: SizedBox(
                        width: width * 0.4,
                        child: ProductView(
                          data: data[index],
                          newHero: newHero,
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
