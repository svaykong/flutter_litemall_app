import 'package:flutter/material.dart';
import 'package:litemall_app/utils/global.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../models/category_model.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.color,
    required this.data,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final Data data;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: onPressed,
              icon: data.attributes.iconUrl.isNotEmpty
                  ? Image.network(
                      data.attributes.iconUrl,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return LoadingAnimationWidget.waveDots(
                          color: Global.secondColor,
                          size: 50,
                        );
                      },
                    )
                  : const Text('No icon'),
            ),
          ),
        ),
        Text(
          data.attributes.title,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
