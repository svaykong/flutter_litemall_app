import 'package:flutter/material.dart';

import '../global.dart';

class TitleShowCase extends StatelessWidget {
  const TitleShowCase({
    Key? key,
    required this.text1,
    this.text2 = 'See All',
    required this.onPressed,
  }) : super(key: key);

  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text2,
            style: const TextStyle(
              color: Global.secondColor,
            ),
          ),
        ),
      ],
    );
  }
}
