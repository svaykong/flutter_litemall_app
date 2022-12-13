import 'package:flutter/material.dart';
import 'package:litemall_app/utils/widgets/slidable_widget.dart';

import 'package:provider/provider.dart';

import '../utils/util.dart';
import '../utils/widgets/alert_confirm.dart';
import '../viewmodels/viewmodel.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(color: Global.thirdColor),
        ),
        actions: [
          IconButton(
            color: productViewModel.cartLists.isEmpty ? Colors.grey : Global.thirdColor,
            onPressed: () {
              if (productViewModel.cartLists.isEmpty) {
                null;
              } else {
                onAlertConfirm(
                  context: context,
                  onYesCallback: () {
                    productViewModel.removeAllFromCart();
                    Navigator.of(context).pop();
                  },
                  title: 'Cart',
                  desc: 'Do you want to delete all the carts?',
                );
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: productViewModel.cartLists.isEmpty
          ? const Center(
              child: Text(
                'There are no carts yet',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.97,
                      width: double.infinity,
                      child: cartItem(context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget cartItem(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: productViewModel.cartLists.length,
        itemBuilder: (BuildContext context, int index) {
          final data = productViewModel.cartLists[index];
          return SlidableWidget(
            onDeletePressed: (context) => productViewModel.removeFromCart(data),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: data.attributes.thumbnail.data == null
                    ? CircleAvatar(
                        child: Text(
                          data.attributes.title.substring(0, 1),
                        ),
                      )
                    : Image.network(
                        Global.host + data.attributes.thumbnail.data!.attributes.url,
                      ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.attributes.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Global.thirdColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '\$ ${data.attributes.price}',
                          style: const TextStyle(
                            color: Global.tenColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Global.elevenColor,
                            ),
                            Text('${data.attributes.rating}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
