import 'package:flutter/material.dart';

import '../views/view.dart';
import '../models/product_model.dart';

class Global {
  static const firstColor = Color(0xFFFFFFFF);
  static const secondColor = Color(0xFF3669C9);
  static const thirdColor = Color(0xFF000000);
  static const fourColor = Color(0xFFC4C5C4);
  static const fiveColor = Color(0xFFE4F3EA);
  static const sixColor = Color(0xFFFFECE8);
  static const sevenColor = Color(0xFFFFF6E4);
  static const eightColor = Color(0xFFF1EDFC);
  static const nineColor = Colors.grey;
  static const tenColor = Colors.red;
  static const elevenColor = Colors.amber;

  static const host = 'https://cms.istad.co';
  static const baseUrl = '/api';
  static var url = '';
  static var param = '';

  static const WISHLIST = '/wishlist';
  static const ORDER = '/order';
  static const ACCOUNT = '/account';
  static const NOTIFICATION = '/notification';
  static const CART = '/cart';
  static const SEARCH = '/search';
  static const PRODUCT_VIEW_DETAIL = '/product_view_detail';

  static Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    WISHLIST: (_) => const WishListView(),
    ORDER: (_) => const OrderView(),
    ACCOUNT: (_) => const AccountView(),
    NOTIFICATION: (_) => const NotificationView(),
    CART: (_) => const CartView(),
    SEARCH: (_) => const SearchView(),
  };

  // Provide a function to handle named routes.
  // Use this function to identify the named
  // route being pushed, and create the correct
  // Screen.
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    // If you push the PassArguments route
    if (settings.name == ProductViewDetail.routeName) {
      // Cast the arguments to the correct
      // type: ScreenArguments.
      final args = settings.arguments as ProductSubDataArguments;

      // Then, extract the required data from
      // the arguments and pass the data to the
      // correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return ProductViewDetail(
            product: args.product,
          );
        },
      );
    }
    // The code only supports
    // PassArgumentsScreen.routeName right now.
    // Other values need to be implemented if we
    // add them. The assertion here will help remind
    // us of that higher up in the call stack, since
    // this assertion would otherwise fire somewhere
    // in the framework.
    assert(false, 'Need to implement ${settings.name}');
    return null;
  };
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ProductSubDataArguments {
  final ProductSubData product;

  const ProductSubDataArguments({required this.product});
}
