import 'package:equatable/equatable.dart';

class ImageResponse extends Equatable {
  int? _id;
  String? _name;
  String? _url;
  String? _createdAt;
  String? _updatedAt;

  ImageResponse({int? id, String? name, String? url, String? createdAt, String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (url != null) {
      _url = url;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get url => _url;

  set url(String? url) => _url = url;

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  String? get updatedAt => _updatedAt;

  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  ImageResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['url'] = _url;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }

  @override
  List<Object?> get props => [_id, _name, _url, _createdAt, _updatedAt];
}
