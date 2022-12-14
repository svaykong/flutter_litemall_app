import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/image_response.dart';
import '../../data/response/api_response.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../utils/util.dart';
import '../../repo/product_repo/product_repo.dart';

abstract class BaseProductViewModel with ChangeNotifier {
  Future<void> getProducts();

  Future<bool> deleteProduct({required int productId});

  Future<bool> updateProduct({required int productId, required ProductSubData requestBody});

  Future<void> uploadImage({required File imgFile});

  Future<bool> createProduct({required Map<String, dynamic> requestBody});
}

class ProductViewModel with ChangeNotifier implements BaseProductViewModel {
  late final ProductRepo _productRepo;
  late ApiResponse<List<ProductSubData>> _products;

  ProductViewModel() {
    _productRepo = ProductRepo.getInstance();
    _products = ApiResponse.loading();
  }

  ApiResponse<List<ProductSubData>> get products => _products;

  List<ProductSubData> _shoes = [];

  List<ProductSubData> get shoes => _shoes;

  List<ProductSubData> _clothes = [];

  List<ProductSubData> get clothes => _clothes;

  List<ProductSubData> _foods = [];

  List<ProductSubData> get foods => _foods;

  List<ProductSubData> _sports = [];

  List<ProductSubData> get sports => _sports;

  List<ProductSubData> _computers = [];

  List<ProductSubData> get computers => _computers;

  // others product
  List<ProductSubData> _featuredPro = [];

  List<ProductSubData> get featuredPro => _featuredPro;
  List<ProductSubData> _bestSellerPro = [];

  List<ProductSubData> get bestSellerPro => _bestSellerPro;
  List<ProductSubData> _newArrivalPro = [];

  List<ProductSubData> get newArrivalPro => _newArrivalPro;
  List<ProductSubData> _topRatedPro = [];

  List<ProductSubData> get topRatedPro => _topRatedPro;
  List<ProductSubData> _specialOfferPro = [];

  List<ProductSubData> get specialOfferPro => _specialOfferPro;

  List<ProductSubData> _proLists = [];

  List<ProductSubData> get proLists => _proLists;

  // wishlist products
  List<ProductSubData> _wishLists = [];

  List<ProductSubData> get wishLists => _wishLists;

  // cart products
  List<ProductSubData> _cartLists = [];

  List<ProductSubData> get cartLists => _cartLists;

  ImageResponse? _imgResponse;

  ImageResponse? get imgResponse => _imgResponse;

  // get all products
  @override
  Future<void> getProducts() async {
    'ProductViewModel getProducts call'.log();
    try {
      int pageCount = 1;
      List<ProductSubData> tmpLists = [];
      for (int i = 0; true; i++) {
        Global.url = '${Global.host}${Global.baseUrl}/e-commerce-products';
        Global.param = '?pagination%5Bpage%5D=$pageCount&populate=%2A';
        final products = await _productRepo.getProducts(url: Global.url + Global.param);

        pageCount++;
        if (products.isEmpty) {
          break;
        }

        tmpLists = [...tmpLists, ...products];
      }

      _products = ApiResponse.complete(tmpLists);
      _loopProduct();
      notifyListeners();
    } catch (e, stackTrace) {
      'ProductViewModel getProducts error :: ${e.toString()}'.log();
      'ProductViewModel getProducts stackTrace :: $stackTrace'.log();
      _products = ApiResponse.error(e.toString());
    } finally {
      'ProductViewModel getProducts finally'.log();
    }
  }

  void _loopProduct() {
    final products = _products.data;
    if (products != null) {
      for (ProductSubData product in products) {
        if (product.attributes.category.data != null) {
          if (Data.fromJson(product.attributes.category.data!.toJson()).id == 1) {
            _shoes = [..._shoes, product];
          } else if (Data.fromJson(product.attributes.category.data!.toJson()).id == 2) {
            _clothes = [..._clothes, product];
          } else if (Data.fromJson(product.attributes.category.data!.toJson()).id == 3) {
            _foods = [..._foods, product];
          } else if (Data.fromJson(product.attributes.category.data!.toJson()).id == 4) {
            _sports = [..._sports, product];
          } else if (Data.fromJson(product.attributes.category.data!.toJson()).id == 5) {
            _computers = [..._computers, product];
          }
        }
      }

      _featuredPro = [...products.where((product) => product.attributes.isFeaturedProduct).toList()];
      _bestSellerPro = [...products.where((product) => product.attributes.isBestSeller).toList()];
      _newArrivalPro = [...products.where((product) => product.attributes.isNewArrival).toList()];
      _topRatedPro = [...products.where((product) => product.attributes.isTopRatedProduct).toList()];
      _specialOfferPro = [...products.where((product) => product.attributes.isSpecialOffer).toList()];
    }
  }

  void getProductContent(ProductSubData product) {
    List<ProductSubData> tmp = [];
    if (product.attributes.isSpecialOffer) {
      tmp = [..._specialOfferPro];
      tmp.removeWhere((element) => element.id == product.id);
      _proLists = tmp;
    } else if (product.attributes.isTopRatedProduct) {
      tmp = [..._topRatedPro];
      tmp.removeWhere((element) => element.id == product.id);
      _proLists = tmp;
    } else if (product.attributes.isNewArrival) {
      tmp = [..._newArrivalPro];
      tmp.removeWhere((element) => element.id == product.id);
      _proLists = tmp;
    } else if (product.attributes.isBestSeller) {
      tmp = [..._bestSellerPro];
      tmp.removeWhere((element) => element.id == product.id);
      _proLists = tmp;
    } else {
      tmp = [..._featuredPro];
      tmp.removeWhere((element) => element.id == product.id);
      _proLists = tmp;
    }
  }

  bool isProductAddedWishList(ProductSubData product) {
    if (_wishLists.isNotEmpty) {
      if (_wishLists.indexOf(product) > -1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // adding products to wishlists
  void addToWishList(ProductSubData product) {
    _wishLists = [..._wishLists, product];
    notifyListeners();
  }

  // remove product from wishlist
  void removeFromWishList(ProductSubData product) {
    _wishLists.remove(product);
    notifyListeners();
  }

  // remove all products from wishlist
  void removeAllFromWishList() {
    _wishLists.clear();
    notifyListeners();
  }

  bool isProductAddedCart(ProductSubData product) {
    if (_cartLists.isNotEmpty) {
      if (_cartLists.indexOf(product) > -1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void addToCart(ProductSubData product) {
    _cartLists = [..._cartLists, product];
    notifyListeners();
  }

  void removeFromCart(ProductSubData product) {
    _cartLists.remove(product);
    notifyListeners();
  }

  void removeAllFromCart() {
    _cartLists.clear();
    notifyListeners();
  }

  // Delete product
  @override
  Future<bool> deleteProduct({required int productId}) async {
    'ProductViewModel deleteProduct call'.log();
    try {
      Global.url = '${Global.host}${Global.baseUrl}/e-commerce-products';
      notifyListeners();
      return await _productRepo.deleteProduct(url: Global.url, productId: productId);
    } catch (e, stackTrace) {
      'ProductViewModel deleteProduct error :: ${e.toString()}'.log();
      'ProductViewModel deleteProduct stackTrace :: $stackTrace'.log();
      // _products = ApiResponse.error(e.toString());
      return false;
    } finally {
      'ProductViewModel deleteProduct finally'.log();
    }
  }

  // update product
  @override
  Future<bool> updateProduct({required int productId, required ProductSubData requestBody}) async {
    'ProductViewModel updateProduct call'.log();

    try {
      Global.url = '${Global.host}${Global.baseUrl}/e-commerce-products';
      final response = await _productRepo.updateProduct(url: Global.url, productId: productId, requestBody: requestBody);
      notifyListeners();
      return response;
    } catch (e, stackTrace) {
      'ProductViewModel updateProduct error :: ${e.toString()}'.log();
      'ProductViewModel updateProduct stackTrace :: $stackTrace'.log();
      // _products = ApiResponse.error(e.toString());
      return false;
    } finally {
      'ProductViewModel updateProduct finally'.log();
    }
  }

  @override
  Future<bool> uploadImage({required File imgFile}) async {
    'ProductViewModel uploadImage call'.log();
    try {
      final ImageResponse response = await _productRepo.uploadImage(imgFile: imgFile);
      'uploadImage response :: $response'.log();
      'image_id :: ${response.id} -- image_name :: ${response.name}'.log();
      if (response.id != null) {
        _imgResponse = response;
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      'ProductViewModel uploadImage error :: ${e.toString()}'.log();
      'ProductViewModel uploadImage stackTrace :: $stackTrace'.log();
      // _products = ApiResponse.error(e.toString());
      return false;
    } finally {
      'ProductViewModel uploadImage finally'.log();
    }
  }

  @override
  Future<bool> createProduct({required Map<String, dynamic> requestBody}) async {
    'ProductViewModel createProduct call'.log();
    try {
      return _productRepo.createProduct(requestBody: requestBody);
    } catch (e, stackTrace) {
      'ProductViewModel createProduct error :: ${e.toString()}'.log();
      'ProductViewModel createProduct stackTrace :: $stackTrace'.log();
      // _products = ApiResponse.error(e.toString());
      return false;
    } finally {
      'ProductViewModel createProduct finally'.log();
    }
  }
}
