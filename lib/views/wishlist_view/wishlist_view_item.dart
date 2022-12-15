import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../utils/util.dart';
import '../../viewmodels/viewmodel.dart';
import '../../utils/widgets/slidable_widget.dart';

class WishListViewItem extends StatelessWidget {
  const WishListViewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.watch<ProductViewModel>();
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: productViewModel.wishLists.length,
      itemBuilder: (BuildContext context, int index) {
        final data = productViewModel.wishLists[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SlidableWidget(
            onDeletePressed: (context) => productViewModel.removeFromWishList(data),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16.0),
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
          ),
        );
      },
    );
  }
}
