import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';

void onAlertConfirm({
  required BuildContext context,
  required VoidCallback onYesCallback,
  required String title,
  required String desc,
}) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: onYesCallback,
        color: const Color.fromRGBO(0, 179, 134, 1.0),
        child: const Text(
          'YES',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Global.secondColor,
        child: const Text(
          'NO',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    ],
  ).show();
}
