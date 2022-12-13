import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:litemall_app/utils/global.dart';

class SlidableWidget<T> extends StatelessWidget {
  const SlidableWidget({
    Key? key,
    required this.child,
    required this.onDeletePressed,
  }) : super(key: key);
  final Widget child;
  final void Function(BuildContext context) onDeletePressed;

  @override
  Widget build(BuildContext context) => Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onDeletePressed,
              backgroundColor: Global.secondColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: child,
      );
}
