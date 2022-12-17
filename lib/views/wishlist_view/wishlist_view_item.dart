import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../utils/util.dart';
import '../../viewmodels/viewmodel.dart';
import '../../utils/widgets/slidable_widget.dart';

class WishListViewItem extends StatelessWidget {
  const WishListViewItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductSubData product;

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: SlidableWidget(
          onDeletePressed: (context) => productViewModel.removeFromWishList(product),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: product.attributes.thumbnail.data == null
                ? CircleAvatar(
                    child: Text(
                      product.attributes.title.substring(0, 1),
                    ),
                  )
                : Image.network(
                    Global.host + product.attributes.thumbnail.data!.attributes.url,
                  ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.attributes.title,
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
                      '\$ ${product.attributes.price}',
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
                        Text('${product.attributes.rating}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
