import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../global.dart';
import '../../views/home_view/product_view/product_view_detail.dart';
// import '../../res/common.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({
    Key? key,
    required this.data,
    this.newHero = false,
  }) : super(key: key);

  final List<ProductSubData> data;
  final bool newHero;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.height;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 32.0,
      ),
      padding: EdgeInsets.zero,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (newHero) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProductViewDetail(
                    product: data[index],
                    newHero: true,
                  ),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductViewDetail(
                    product: data[index],
                  ),
                ),
              );
            }
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data[index].attributes.thumbnail.data == null
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Image not available',
                          style: TextStyle(
                            color: Global.thirdColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Hero(
                        tag: newHero
                            ? data[index].attributes.thumbnail.data!.attributes.name + data[index].attributes.thumbnail.data!.attributes.url
                            : data[index].attributes.thumbnail.data!.attributes.name,
                        child: Image.network(
                          Global.host + data[index].attributes.thumbnail.data!.attributes.url,
                          fit: BoxFit.fitHeight,
                          height: height * 0.13,
                          width: double.infinity,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    data[index].attributes.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Global.thirdColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ ${data[index].attributes.price}',
                        style: const TextStyle(
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
                          Text('${data[index].attributes.rating}'),
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///////////
// newHero
//     ? Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepOrange,
//                 ),
//                 onPressed: () {
//                   'Add to wishlist pressed ...'.log();
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: const [
//                     Text('Added '),
//                     Icon(Icons.favorite),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 16.0,
//             ),
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepPurple,
//                 ),
//                 onPressed: () {
//                   'Add to cart pressed ...'.log();
//                 },
//                 child: const Text('Add to Cart'),
//               ),
//             ),
//           ],
//         ),
//       )
//     : const SizedBox.shrink(),
//////////
