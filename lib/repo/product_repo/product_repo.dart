import '../../models/product_model.dart';
import '../../data/network/network_api_service.dart';

abstract class BaseProductRepo {
  Future<List<ProductSubData>> getProducts({required String url});

  Future<bool> deleteProduct({required String url, required int productId});

  Future<bool> updateProduct({required String url, required int productId, required ProductSubData requestBody});
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
}
