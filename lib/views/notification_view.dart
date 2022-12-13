import 'package:flutter/material.dart';

import '../utils/util.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(color: Global.thirdColor),
        ),
      ),
      body: const Center(
        child: Text(
          'There are no notification yet',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
