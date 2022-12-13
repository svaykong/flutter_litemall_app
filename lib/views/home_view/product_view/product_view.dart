import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../models/product_model.dart';
import '../../../utils/util.dart';
import '../product_view/product_view_detail.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    Key? key,
    required this.data,
    this.newHero = false,
  }) : super(key: key);

  final ProductSubData data;
  final bool newHero;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (newHero) {
          Navigator.of(context).pushReplacementNamed(ProductViewDetail.routeName, arguments: data);
        } else {
          Navigator.of(context).pushNamed(ProductViewDetail.routeName, arguments: ProductSubDataArguments(product: data));
        }
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
              data.attributes.thumbnail.data != null
                  ? Hero(
                      tag: newHero
                          ? data.attributes.thumbnail.data!.attributes.name + data.attributes.thumbnail.data!.attributes.url
                          : data.attributes.thumbnail.data!.attributes.name,
                      child: Image.network(
                        Global.host + data.attributes.thumbnail.data!.attributes.url,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: height * 0.15,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Image not available',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
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
                    GestureDetector(
                      child: const Icon(Icons.more_vert),
                      onTap: () {
                        '${data.attributes.title} -- More click ...'.log();

                        // Alert custom content
                        Alert(
                          context: context,
                          // title: 'Product',
                          // content: Column(
                          //   children: const <Widget>[
                          //     // TextField(
                          //     //   decoration: InputDecoration(
                          //     //     icon: Icon(Icons.account_circle),
                          //     //     labelText: 'Username',
                          //     //   ),
                          //     // ),
                          //     TextField(
                          //       obscureText: true,
                          //       decoration: InputDecoration(
                          //         icon: Icon(Icons.lock),
                          //         labelText: 'Password',
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              color: Global.secondColor,
                              child: const Text(
                                'EDIT',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              color: Colors.red,
                              child: const Text(
                                'DELETE',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ).show();
                      },
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
