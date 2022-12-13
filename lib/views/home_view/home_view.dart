import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/util.dart';
import './category_showcase.dart';
import './product_showcase.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  double _height = 0;

  // double _width = 0;
  final CarouselController _carouselCtr = CarouselController();

  final List<String> _items = [
    'assets/imgs/banner_1.png',
    'assets/imgs/banner_2.png',
    'assets/imgs/banner_3.png',
    'assets/imgs/banner_4.png',
  ];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    // _width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            // Search Placeholder
            SearchPlaceholder(
              onTap: () => Navigator.of(context).pushNamed(Global.SEARCH),
            ),

            // Banner Showcase
            _getBannerShowCase(context),

            // Categories showcase
            const CategoriesShowCase(),

            // Products Showcase
            const ProductsShowCase(),
          ],
        ),
      ),
    );
  }

  Widget _getBannerShowCase(BuildContext context) {
    return Column(
      children: [
        // Banner images
        CarouselSlider(
          carouselController: _carouselCtr,
          options: CarouselOptions(
            height: _height * 0.23,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 2000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          items: _items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(i);
              },
            );
          }).toList(),
        ),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _items.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselCtr.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Global.firstColor : Global.thirdColor)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
