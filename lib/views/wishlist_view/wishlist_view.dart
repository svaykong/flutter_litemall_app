import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../utils/global.dart';
import '../../utils/widgets/alert_confirm.dart';
import '../../viewmodels/viewmodel.dart';
import 'wishlist_view_item.dart';
import 'package:litemall_app/utils/util.dart';

class WishListView extends StatelessWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: [
          IconButton(
            color: productViewModel.wishLists.isEmpty ? Colors.grey : Global.thirdColor,
            onPressed: () {
              if (productViewModel.wishLists.isEmpty) {
                null;
              } else {
                onAlertConfirm(
                  context: context,
                  onYesCallback: () {
                    productViewModel.removeAllFromWishList();
                    Navigator.of(context).pop();
                  },
                  title: 'Wishlist',
                  desc: 'Do you want to delete all the wishlists?',
                );
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: productViewModel.wishLists.isEmpty
          ? const Center(
              child: Text(
                'There are no wishlists yet',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: const WishListViewItem(),
              ),
            ),
    );
  }
}
