import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

import '../global.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'No internet connection\n\n',
                children: [
                  TextSpan(
                    text: 'Connect to the internet and try again',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
                style: TextStyle(
                  color: Global.thirdColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: callback,
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
