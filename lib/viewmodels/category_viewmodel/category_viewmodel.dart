import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../utils/util.dart';
import '../../repo/category_repo/category_repo.dart';
import '../../data/response/api_response.dart';

abstract class BaseCategoryViewModel with ChangeNotifier {
  Future<void> getCategories();
}

class CategoryViewModel with ChangeNotifier implements BaseCategoryViewModel {
  late final CategoryRepo _categoryRepo;
  late ApiResponse<List<Data>> _categories;

  CategoryViewModel() {
    _categoryRepo = CategoryRepo.getInstance();
    _categories = ApiResponse.loading();
  }

  ApiResponse<List<Data>> get categories => _categories;

  @override
  Future<void> getCategories() async {
    'CategoryViewModel getCategories call'.log();
    try {
      Global.url = '${Global.host}${Global.baseUrl}/e-commerce-categories';
      int pageCount = 1;
      Global.param = '?pagination%5Bpage%5D=$pageCount';
      final categories = await _categoryRepo.getCategories(url: Global.url + Global.param);
      _categories = ApiResponse.complete(categories);

      notifyListeners();
    } catch (e, stackTrace) {
      'CategoryViewModel getProducts error :: ${e.toString()}'.log();
      'CategoryViewModel getProducts stackTrace :: $stackTrace'.log();
      _categories = ApiResponse.error(e.toString());
    } finally {
      'CategoryViewModel getCategories finally'.log();
    }
  }
}
