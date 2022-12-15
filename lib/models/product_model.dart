import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../utils/util.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.productListData,
    required this.productMeta,
  });

  final List<ProductSubData> productListData;
  final ProductSubMeta productMeta;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productListData: List.from(json['data']).map((element) => ProductSubData.fromJson(element)).toList(),
      productMeta: ProductSubMeta.fromJson(json['meta']),
    );
  }

  @override
  List<Object?> get props => [productListData, productMeta];
}

class ProductSubData extends Equatable {
  const ProductSubData({
    required this.id,
    required this.attributes,
  });

  final int id;
  final ProductSubAttribute attributes;

  factory ProductSubData.fromJson(Map<String, dynamic> json) {
    return ProductSubData(
      id: json['id'].toString().parseNum().toInt(),
      attributes: ProductSubAttribute.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> subData = <String, dynamic>{};
    subData['title'] = attributes.title;
    subData['rating'] = attributes.rating.toString();
    subData['description'] = attributes.description;
    subData['quantity'] = attributes.quantity.toString();
    subData['category'] = attributes.category.data!.id.toString();
    subData['thumbnail'] = null; //attributes.thumbnail.id.toString();
    subData['price'] = attributes.price.toString();

    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = subData;
    return data;
  }

  @override
  List<Object?> get props => [id, attributes];
}

class ProductSubAttribute extends Equatable {
  ProductSubAttribute({
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.price,
    required this.rating,
    required this.description,
    required this.quantity,
    this.isFeaturedProduct = false,
    this.isBestSeller = false,
    this.isNewArrival = false,
    this.isTopRatedProduct = false,
    this.isSpecialOffer = false,
    required this.category,
    required this.thumbnail,
  });

  String title;
  String createdAt;
  String updatedAt;
  String publishedAt;
  double price;
  double rating;
  String description;
  int quantity;
  bool isFeaturedProduct;
  bool isBestSeller;
  bool isNewArrival;
  bool isTopRatedProduct;
  bool isSpecialOffer;
  ProductSubCategory category;
  Thumbnail thumbnail;

  factory ProductSubAttribute.fromJson(Map<String, dynamic> json) {
    double price = json['price'].toString().parseNum().toDouble();
    return ProductSubAttribute(
      title: json['title'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      publishedAt: json['publishedAt'],
      price: price,
      rating: '${json['rating'].toString()}rating'.parseNum().toDouble(),
      description: json['description'],
      quantity: json['quantity'].toString().parseNum().toInt(),
      isFeaturedProduct: price > 60,
      isBestSeller: price > 50 && price <= 60,
      isNewArrival: price > 40 && price <= 50,
      isTopRatedProduct: price > 20 && price <= 40,
      isSpecialOffer: price > 0 && price <= 20,
      category: ProductSubCategory.fromJson(json['category']),
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
    );
  }

  @override
  List<Object?> get props => [
        title,
        createdAt,
        updatedAt,
        publishedAt,
        price,
        rating,
        description,
        quantity,
        isFeaturedProduct,
        isBestSeller,
        isNewArrival,
        isTopRatedProduct,
        isSpecialOffer,
        category,
        thumbnail,
      ];
}

class ProductSubCategory extends Equatable {
  const ProductSubCategory({required this.data});

  final ProductSubCategorySubData? data;

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) {
    return ProductSubCategory(data: json['data'] != null ? ProductSubCategorySubData.fromJson(json['data']) : null);
  }

  @override
  List<Object?> get props => [data];
}

class ProductSubCategorySubData extends Equatable {
  ProductSubCategorySubData({
    required this.id,
    // required this.attributes,
    this.jsonAttributes,
  });

  int id;
  final Map<String, dynamic>? jsonAttributes;

//   final CategorySubAttribute attributes;

  factory ProductSubCategorySubData.fromJson(Map<String, dynamic> json) {
    return ProductSubCategorySubData(
      id: json['id'],
      // attributes: CategorySubAttribute.fromJson(json['attributes']),
      jsonAttributes: json['attributes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attributes'] = jsonAttributes;
    return data;
  }

  @override
  List<Object?> get props => [id];
}

// class CategorySubAttribute extends Equatable {
//   const CategorySubAttribute({
//     required this.title,
//     required this.iconUrl,
//   });
//
//   final String title;
//   final String iconUrl;
//
//   factory CategorySubAttribute.fromJson(Map<String, dynamic> json) {
//     String title = json['title'] ?? '';
//     title = title.indexOf(',') > -1 ? title.substring(0, title.indexOf(',')) : title;
//     if (title.isNotEmpty) {
//       title = title.substring(0, 1).toUpperCase() + title.substring(1, title.length);
//     }
//     return CategorySubAttribute(
//       title: title,
//       iconUrl: json['iconUrl'] ?? '',
//     );
//   }
//
//   @override
//   List<Object?> get props => [title, iconUrl];
// }
//

class Thumbnail extends Equatable {
  const Thumbnail({
    required this.id,
    this.data,
  });

  final int id;
  final ThumbnailSubData? data;

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      id: json['id'].toString().parseNum().toInt(),
      data: json['data'] != null ? ThumbnailSubData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [id, data];
}

class ThumbnailSubData extends Equatable {
  const ThumbnailSubData({
    required this.id,
    required this.attributes,
  });

  final int id;
  final ThumbnailSubAttributes attributes;

  factory ThumbnailSubData.fromJson(Map<String, dynamic> json) {
    return ThumbnailSubData(
      id: json['int'].toString().parseNum().toInt(),
      attributes: ThumbnailSubAttributes.fromJson(json['attributes']),
    );
  }

  @override
  List<Object?> get props => [id, attributes];
}

class ThumbnailSubAttributes extends Equatable {
  const ThumbnailSubAttributes({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory ThumbnailSubAttributes.fromJson(Map<String, dynamic> json) {
    return ThumbnailSubAttributes(
      name: json['name'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [name, url];
}

class ProductSubMeta extends Equatable {
  const ProductSubMeta({required this.pagination});

  final ProductSubPagination pagination;

  factory ProductSubMeta.fromJson(Map<String, dynamic> json) => ProductSubMeta(pagination: ProductSubPagination.fromJson(json['pagination']));

  @override
  List<Object?> get props => [pagination];
}

class ProductSubPagination extends Equatable {
  const ProductSubPagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  factory ProductSubPagination.fromJson(Map<String, dynamic> json) => ProductSubPagination(
        page: json['page'].toString().parseNum().toInt(),
        pageSize: json['pageSize'].toString().parseNum().toInt(),
        pageCount: json['pageCount'].toString().parseNum().toInt(),
        total: json['total'].toString().parseNum().toInt(),
      );

  @override
  List<Object?> get props => [page, pageSize, pageCount, total];
}
