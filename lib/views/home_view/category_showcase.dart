import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/category_model.dart';
import '../../viewmodels/viewmodel.dart';

import '../../views/home_view/cateogory_view/category_detail_view.dart';
import '../../views/home_view/cateogory_view/category_view.dart';
import '../../utils/util.dart';

class CategoriesShowCase extends StatelessWidget {
  const CategoriesShowCase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    final listData = context.read<CategoryViewModel>().categories.data;
    if (listData == null) {
      return const Text('No categories');
    }
    return Column(
      children: [
        TitleShowCase(
          text1: 'Categories',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    alignment: Alignment.center,
                    color: Global.firstColor,
                    height: height / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'All Categories',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: _categoriesContents(context, showWrap: true, listData: listData),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(
          height: height * 0.12,
          width: double.infinity,
          child: _categoriesContents(context, listData: listData),
        ),
      ],
    );
  }

  Widget _categoriesContents(BuildContext context, {bool showWrap = false, required List<Data> listData}) {
    Color color = Global.firstColor;
    Color getColor(int idx) {
      switch (idx) {
        case 0:
        case 4:
          color = Global.fiveColor;
          break;
        case 1:
          color = Global.sixColor;
          break;
        case 2:
          color = Global.sevenColor;
          break;
        case 3:
          color = Global.eightColor;
          break;
      }
      return color;
    }

    if (showWrap) {
      return Wrap(
        spacing: 8.0,
        children: listData.asMap().entries.map((entry) {
          int index = entry.key;
          Data category = entry.value;
          color = getColor(index);
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
            child: CategoryView(
              color: color,
              data: category,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryDetailView(data: listData[index]),
                  ),
                );
              },
            ),
          );
        }).toList(),
      );
    }
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listData.length,
        itemBuilder: (context, int index) {
          color = getColor(index);
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CategoryView(
              color: color,
              data: listData[index],
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoryDetailView(data: listData[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
