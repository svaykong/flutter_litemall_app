import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

import '../../../viewmodels/viewmodel.dart';
import '../../../models/product_model.dart';
import '../../../utils/util.dart';
import '../product_view/product_widgets/product_content.dart';

class ProductViewDetail extends StatelessWidget {
  const ProductViewDetail({
    Key? key,
    required this.product,
    this.newHero = false,
  }) : super(key: key);

  static const routeName = '/product_view_detail';
  final ProductSubData product;
  final bool newHero;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final height = MediaQuery.of(context).size.height;
    final productViewModel = context.watch<ProductViewModel>()..getProductContent(product);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(color: Global.thirdColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Share.share('check out my website https://example.com'),
            icon: const Icon(Icons.share),
            color: Global.thirdColor,
          ),
          StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return CustomIconButton(
                onPressed: () => Navigator.of(context).pushNamed(Global.CART).then((value) => setState(() => {})),
                icon: CustomIcon.cart,
                showBadge: productViewModel.cartLists.isNotEmpty ? true : false,
              );
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.attributes.thumbnail.data == null
                  ? const Text('Image not available')
                  : Card(
                      margin: EdgeInsets.zero,
                      child: Hero(
                        tag: newHero
                            ? product.attributes.thumbnail.data!.attributes.name + product.attributes.thumbnail.data!.attributes.url
                            : product.attributes.thumbnail.data!.attributes.name,
                        child: Image.network(
                          Global.host + product.attributes.thumbnail.data!.attributes.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: height * 0.35,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                product.attributes.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.attributes.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Global.tenColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Global.elevenColor,
                      ),
                      Text(
                        '${product.attributes.rating}',
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      color: Global.fourColor,
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: const Text('Available : 250'),
                  ),
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(
                height: 32.0,
              ),
              const Text(
                'Description Product',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Text(
                product.attributes.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 32.0,
              ),
              /////////////////////////////////////////
              // nested ProductContent is complex
              ProductContent(
                data: productViewModel.proLists,
                newHero: true,
              ),
              /////////////////////////////////////////
              const SizedBox(
                height: 16.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                        ),
                        onPressed: () {
                          if (productViewModel.isProductAddedWishList(product)) {
                            productViewModel.removeFromWishList(product);
                          } else {
                            productViewModel.addToWishList(product);
                            Toast.show('Success added to wishlist', gravity: Toast.top, duration: 2, backgroundRadius: 10);
                          }
                        },
                        child: productViewModel.isProductAddedWishList(product)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text('Added '),
                                  Icon(Icons.favorite),
                                ],
                              )
                            : const Text('Added to Wishlist'),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          if (productViewModel.isProductAddedCart(product)) {
                            productViewModel.removeFromCart(product);
                          } else {
                            productViewModel.addToCart(product);
                            Toast.show('Success added to cart', gravity: Toast.top, duration: 2, backgroundRadius: 10);
                          }
                        },
                        child: productViewModel.isProductAddedCart(product)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text('Added '),
                                  Icon(CustomIcon.cart),
                                ],
                              )
                            : const Text('Add to Cart'),
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
