import 'dart:convert' show jsonDecode;
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../app_exception.dart';
import '../../utils/util.dart';

@immutable
abstract class BaseNetworkApiService {
  Future<List<Data>> getCategories({required String url});

  Future<List<ProductSubData>> getProducts({required String url});

  Future<Map<String, dynamic>> returnResponse({required Response response});
}

class NetworkApiService implements BaseNetworkApiService {
  const NetworkApiService._();

  static NetworkApiService getInstance() => const NetworkApiService._();

  static final Client _client = Client();

  @override
  Future<List<Data>> getCategories({required String url}) async {
    'NetworkApiService getCategories call'.log();
    try {
      final response = await _client.get(Uri.parse(url));
      final resultJson = await returnResponse(response: response);
      return CategoryModel.fromJson(resultJson).listData;
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService getProducts error :: $e'.log();
      'NetworkApiService getProducts StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService getCategories unexpected error : $e');
    } finally {
      'NetworkApiService getCategories finally'.log();
    }
  }

  @override
  Future<List<ProductSubData>> getProducts({required String url}) async {
    'NetworkApiService getProducts call'.log();
    try {
      final Response response = await _client.get(Uri.parse(url));
      final resultJson = await returnResponse(response: response);
      return ProductModel.fromJson(resultJson).productListData;
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService getProducts error :: $e'.log();
      'NetworkApiService getProducts StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService getProducts unexpected error : $e');
    } finally {
      'NetworkApiService getProducts finally'.log();
    }
  }

  @override
  Future<Map<String, dynamic>> returnResponse({required Response response}) async {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw const FetchDataException('unexpected error occurred');
    }
  }
}

// TODO: implement upload image
// @override
// Future<void> uploadImage() async {
//   try {
//   } on SocketException {
//     throw const FetchDataException('no internet connection');
//   }
// }

// TODO: implement post
// @override
// Future<bool> post(String url) async {
//   try {
//     final response = await _client.post(Uri.parse(url));
//     final json = await returnJsonResponse(response);
//     return false;
//   } on SocketException {
//     throw const FetchDataException('no internet connection');
//   } catch (e) {
//     print('post error : $e');
//     throw FetchDataException('post unexpected error : $e');
//   }
// }
// }
