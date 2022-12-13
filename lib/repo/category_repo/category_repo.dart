import '../../models/category_model.dart';
import '../../data/network/network_api_service.dart';

abstract class BaseCategoryRepo {
  Future<List<Data>> getCategories({required String url});
}

class CategoryRepo implements BaseCategoryRepo {
  CategoryRepo._();

  static late final NetworkApiService _apiService;

  static CategoryRepo getInstance() {
    _apiService = NetworkApiService.getInstance();
    return CategoryRepo._();
  }

  @override
  Future<List<Data>> getCategories({required String url}) async {
    return await _apiService.getCategories(url: url);
  }
}
