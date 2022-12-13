import '../../models/product_model.dart';
import '../../data/network/network_api_service.dart';

abstract class BaseProductRepo {
  Future<List<ProductSubData>> getProducts({required String url});
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
}
