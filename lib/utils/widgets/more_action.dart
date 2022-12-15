import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';

Future<bool?> moreAction({required BuildContext context, required VoidCallback onEditPressed, required VoidCallback onDeletePressed}) {
  return Alert(
    context: context,
    title: 'More Action',
    buttons: [
      DialogButton(
        onPressed: onEditPressed,
        color: Global.secondColor,
        child: const Text(
          'EDIT',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      DialogButton(
        onPressed: onDeletePressed,
        color: Colors.red,
        child: const Text(
          'DELETE',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  ).show();
}
