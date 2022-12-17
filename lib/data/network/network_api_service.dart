import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../models/image_response.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../app_exception.dart';
import '../../utils/util.dart';

@immutable
abstract class BaseNetworkApiService {
  Future<List<Data>> getCategories({required String url});

  Future<List<ProductSubData>> getProducts({required String url});

  Future<bool> deleteProduct({required String url, required int productId});

  Future<bool> updateProduct({required String url, required int productId, required ProductSubData requestBody});

  Future<ImageResponse> uploadImage({required File imgFile});

  Future<bool> createProduct({required Map<String, dynamic> requestBody});

  Future<Map<String, dynamic>> returnResponse({required http.Response response});
}

class NetworkApiService implements BaseNetworkApiService {
  const NetworkApiService._();

  static NetworkApiService getInstance() => const NetworkApiService._();

  static final http.Client _client = http.Client();

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
      final http.Response response = await _client.get(Uri.parse(url));
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
  Future<bool> deleteProduct({required String url, required int productId}) async {
    'NetworkApiService deleteProduct call'.log();
    try {
      final http.Response response = await _client.delete(
        Uri.parse(Uri.encodeFull('$url/$productId')),
        headers: Global.headers,
      );
      'response :: ${response.body}'.log();
      if (response.body.indexOf('"id":$productId') > -1) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService deleteProduct error :: $e'.log();
      'NetworkApiService deleteProduct StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService deleteProduct unexpected error : $e');
    } finally {
      'NetworkApiService deleteProduct finally'.log();
    }
  }

  @override
  Future<bool> updateProduct({required String url, required int productId, required ProductSubData requestBody}) async {
    'NetworkApiService updateProduct call'.log();
    try {
      final http.Response response = await _client.put(
        Uri.parse(Uri.encodeFull('$url/$productId')),
        headers: Global.headers,
        body: jsonEncode(requestBody.toJson()),
      );
      'jsonEncode updateProduct :: ${jsonEncode(requestBody.toJson())}'.log();
      'response :: ${response.body}'.log();
      if (response.body.indexOf('"id":$productId') > -1) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService updateProduct error :: $e'.log();
      'NetworkApiService updateProduct StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService updateProduct unexpected error : $e');
    } finally {
      'NetworkApiService updateProduct finally'.log();
    }
  }

  @override
  Future<ImageResponse> uploadImage({required File imgFile}) async {
    'NetworkApiService uploadImage call'.log();
    try {
      Global.url = '/upload';
      final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(Global.host + Global.baseUrl + Global.url));
      request.files.add(await http.MultipartFile.fromPath('files', imgFile.path));
      final http.StreamedResponse response = await request.send();
      final resource = await response.stream.bytesToString();
      print(resource);
      final decode = jsonDecode(resource);
      List<ImageResponse> imgResponse = List.from(decode).map((e) => ImageResponse.fromJson(e)).toList();
      return imgResponse[0];
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService uploadImage error :: $e'.log();
      'NetworkApiService uploadImage StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService uploadImage unexpected error : $e');
    } finally {
      'NetworkApiService uploadImage finally'.log();
    }
  }

  @override
  Future<bool> createProduct({required Map<String, dynamic> requestBody}) async {
    'NetworkApiService createProduct call'.log();
    try {
      Global.url = '${Global.host}${Global.baseUrl}/e-commerce-products';
      final http.Response response = await _client.post(
        Uri.parse(Uri.encodeFull(Global.url)),
        headers: Global.headers,
        body: jsonEncode(requestBody),
      );
      'jsonEncode createProduct :: ${jsonEncode(requestBody)}'.log();
      'response :: ${response.body}'.log();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException {
      throw const FetchDataException('no internet connection');
    } catch (e, stackTrace) {
      'NetworkApiService createProduct error :: $e'.log();
      'NetworkApiService createProduct StackTrace :: $stackTrace'.log();
      throw FetchDataException('NetworkApiService createProduct unexpected error : $e');
    } finally {
      'NetworkApiService createProduct finally'.log();
    }
  }

  @override
  Future<Map<String, dynamic>> returnResponse({required http.Response response}) async {
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
