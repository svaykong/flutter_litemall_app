import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../models/product_model.dart';
import '../../viewmodels/product_viewmodel/product_viewmodel.dart';
import '../../views/update_view/update_view.dart';
import '../global.dart';
import '../../views/home_view/product_view/product_view_detail.dart';
import 'more_action.dart';

class CardGridView extends StatefulWidget {
  const CardGridView({
    Key? key,
    required this.data,
    required this.productType,
  }) : super(key: key);

  final List<ProductSubData> data;
  final String productType;

  @override
  State<CardGridView> createState() => _CardGridViewState();
}

class _CardGridViewState extends State<CardGridView> {
  List<ProductSubData> _listCardGrid = [];

  @override
  void initState() {
    super.initState();
    _listCardGrid = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final height = MediaQuery.of(context).size.height;
    final productViewModel = context.watch<ProductViewModel>();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 32.0,
      ),
      padding: EdgeInsets.zero,
      itemCount: _listCardGrid.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductViewDetail(
                  productType: 'card_grid',
                  product: _listCardGrid[index],
                ),
              ),
            );
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _listCardGrid[index].attributes.thumbnail.data == null
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
                        tag: '${widget.productType}-$index-${_listCardGrid[index].attributes.thumbnail.data!.id}',
                        child: Image.network(
                          Global.host + _listCardGrid[index].attributes.thumbnail.data!.attributes.url,
                          fit: BoxFit.fill,
                          height: height * 0.13,
                          width: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return LoadingAnimationWidget.waveDots(
                              color: Global.secondColor,
                              size: 50,
                            );
                          },
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    _listCardGrid[index].attributes.title,
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
                        '\$ ${_listCardGrid[index].attributes.price}',
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
                          Text('${_listCardGrid[index].attributes.rating}'),
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.more_vert,
                          size: 18,
                        ),
                        onPressed: () => moreAction(
                          context: context,
                          onEditPressed: () async {
                            Navigator.of(context).pop();
                            await Navigator.of(context).pushNamed(UpdateView.routeName).then((value) {
                              setState(() {});
                            });
                          },
                          onDeletePressed: () {
                            productViewModel.deleteProduct(productId: _listCardGrid[index].id).then((value) {
                              Navigator.of(context).pop();
                              Toast.show('Success delete', gravity: Toast.top, duration: 3);
                              setState(() {
                                _listCardGrid.remove(_listCardGrid[index]);
                              });
                            });
                          },
                        ),
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
