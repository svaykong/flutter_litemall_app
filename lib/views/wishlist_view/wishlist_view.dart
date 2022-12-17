import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../utils/global.dart';
import '../../utils/widgets/alert_confirm.dart';
import '../../viewmodels/viewmodel.dart';
import 'wishlist_view_item.dart';
import 'package:litemall_app/utils/util.dart';

class WishListView extends StatefulWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  List<ProductSubData> _wishlists = [];
  late final ProductViewModel _productViewModel;

  void _init() async {
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    _wishlists = _productViewModel.wishLists;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: [
          IconButton(
            color: _wishlists.isEmpty ? Colors.grey : Global.thirdColor,
            onPressed: () {
              if (_wishlists.isEmpty) {
                null;
              } else {
                onAlertConfirm(
                  context: context,
                  onYesCallback: () {
                    _productViewModel.removeAllFromWishList();
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
      body: _wishlists.isEmpty
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
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _wishlists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return WishListViewItem(product: _wishlists[index]);
                  },
                ),
              ),
            ),
    );
  }
}
