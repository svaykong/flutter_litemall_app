import 'package:equatable/equatable.dart';

import '../utils/util.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.listData,
    required this.meta,
  });

  final List<Data> listData;
  final Meta meta;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      listData: List.from(json['data']).map((element) => Data.fromJson(element)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }

  @override
  List<Object?> get props => [listData, meta];
}

class Data extends Equatable {
  const Data({
    required this.id,
    required this.attributes,
  });

  final int id;
  final Attribute attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'].toString().parseNum().toInt(),
        attributes: Attribute.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attributes'] = attributes;
    return data;
  }

  @override
  List<Object?> get props => [id, attributes];
}

class Attribute extends Equatable {
  const Attribute({
    required this.title,
    required this.iconUrl,
  });

  final String title;
  final String iconUrl;

  factory Attribute.fromJson(Map<String, dynamic> json) {
    String title = json['title'] ?? '';
    title = title.indexOf(',') > -1 ? title.substring(0, title.indexOf(',')) : title;
    if (title.isNotEmpty) {
      title = title.substring(0, 1).toUpperCase() + title.substring(1, title.length);
    }
    return Attribute(
      title: title,
      iconUrl: json['iconUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [title, iconUrl];
}

class Meta extends Equatable {
  const Meta({required this.pagination});

  final Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(pagination: Pagination.fromJson(json['pagination']));

  @override
  List<Object?> get props => [pagination];
}

class Pagination extends Equatable {
  const Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json['page'].toString().parseNum().toInt(),
        pageSize: json['pageSize'].toString().parseNum().toInt(),
        pageCount: json['pageCount'].toString().parseNum().toInt(),
        total: json['total'].toString().parseNum().toInt(),
      );

  @override
  List<Object?> get props => [page, pageSize, pageCount, total];
}
