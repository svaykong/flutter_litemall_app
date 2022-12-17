import 'dart:io';

import '../../models/image_response.dart';
import '../../models/product_model.dart';
import '../../data/network/network_api_service.dart';

abstract class BaseProductRepo {
  Future<List<ProductSubData>> getProducts({required String url});

  Future<bool> deleteProduct({required String url, required int productId});

  Future<bool> updateProduct({required String url, required int productId, required ProductSubData requestBody});

  Future<ImageResponse> uploadImage({required File imgFile});

  Future<bool> createProduct({required Map<String, dynamic> requestBody});
}

class ProductRepo implements BaseProductRepo {
  ProductRepo._();

  static late final NetworkApiService _apiService;

  static ProductRepo getInstance() {
    _apiService = NetworkApiService.getInstance();
    return ProductRepo._();
  }

  @override
  Future<List<ProductSubData>> getProducts({required String url}) async {
    return await _apiService.getProducts(url: url);
  }

  @override
  Future<bool> deleteProduct({required String url, required int productId}) async {
    return await _apiService.deleteProduct(url: url, productId: productId);
  }

  @override
  Future<bool> updateProduct({required String url, required int productId, required ProductSubData requestBody}) async {
    return await _apiService.updateProduct(url: url, productId: productId, requestBody: requestBody);
  }

  @override
  Future<ImageResponse> uploadImage({required File imgFile}) async {
    return await _apiService.uploadImage(imgFile: imgFile);
  }

  @override
  Future<bool> createProduct({required Map<String, dynamic> requestBody}) async {
    return await _apiService.createProduct(requestBody: requestBody);
  }
}
