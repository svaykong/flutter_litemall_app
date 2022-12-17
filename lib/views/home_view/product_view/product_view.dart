import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../models/product_model.dart';
import '../../../utils/util.dart';
import '../../../utils/widgets/more_action.dart';
import '../../update_view/update_view.dart';
import '../../../viewmodels/product_viewmodel/product_viewmodel.dart';
import '../product_view/product_view_detail.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    Key? key,
    required this.productType,
    required this.data,
    this.onProductUpdate,
  }) : super(key: key);

  final String productType;
  final ProductSubData data;
  final VoidCallback? onProductUpdate;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final productViewModel = context.watch<ProductViewModel>();
    ToastContext().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductViewDetail.routeName,
          arguments: ProductSubDataArguments(product: data, productType: productType),
        );
      },
      child: SizedBox(
        width: width * 0.4,
        child: Card(
          elevation: 3,
          color: Global.firstColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data.attributes.thumbnail.data == null
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Image not available',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Hero(
                      tag: 'product-view-$productType-${data.attributes.thumbnail.data!.id}',
                      child: Image.network(
                        Global.host + data.attributes.thumbnail.data!.attributes.url,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: height * 0.15,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: LoadingAnimationWidget.waveDots(
                              color: Global.secondColor,
                              size: 100,
                            ),
                          );
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  data.attributes.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${data.attributes.price}',
                      style: const TextStyle(
                        color: Global.tenColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Global.elevenColor,
                        ),
                        Text(
                          data.attributes.rating.toString(),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => GestureDetector(
                        child: const Icon(Icons.more_vert),
                        onTap: () => moreAction(
                          context: context,
                          onEditPressed: () async {
                            Navigator.of(context).pop();
                            await Navigator.of(context)
                                .pushNamed(
                              UpdateView.routeName,
                              arguments: UpdateProductArguments(product: data),
                            )
                                .then(
                              (value) {
                                setState(() {});
                              },
                            );
                          },
                          onDeletePressed: () {
                            productViewModel.deleteProduct(productId: data.id).then((value) {
                              Navigator.of(context).pop();
                              Toast.show('Success delete', gravity: Toast.top, duration: 3);
                              if (onProductUpdate != null) {
                                onProductUpdate!();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
