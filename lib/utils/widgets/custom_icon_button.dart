import 'package:flutter/material.dart';

import '../global.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconColor = Global.thirdColor,
    this.badgeColor = Global.tenColor,
    this.showBadge = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color badgeColor;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Stack(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          showBadge
              ? Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 5.0,
                    backgroundColor: badgeColor,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
