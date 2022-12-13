import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/global.dart';
import '../../viewmodels/user_viewmodel/user_viewmodel.dart';

import 'custom_icon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, this.filePath = ''});

  final String filePath;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late UserViewModel _userViewModel;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false)..getImgPathFromLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Global.thirdColor,
      showUnselectedLabels: true,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(CustomIcon.home),
          label: 'HOME',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            CustomIcon.heart,
          ),
          label: 'WISHLIST',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            CustomIcon.bag,
          ),
          label: 'ORDER',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage:
                _userViewModel.filePath != '' ? Image.file(File(_userViewModel.filePath)).image : const AssetImage('assets/imgs/user_placeholder.jpg'),
          ),
          label: 'ACCOUNT',
        ),
      ],
      fixedColor: Global.secondColor,
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.of(context).pushNamed(Global.WISHLIST);
            break;
          case 2:
            Navigator.of(context).pushNamed(Global.ORDER);
            break;
          case 3:
            Navigator.of(context).pushNamed(Global.ACCOUNT).then((value) => setState(() {}));
            break;
        }
      },
    );
  }
}
