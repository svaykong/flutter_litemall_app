import 'package:flutter/cupertino.dart';

import '../../utils/util.dart';

abstract class BaseUserViewModel with ChangeNotifier {
  Future<void> getImgPathFromLocalData();

  Future<void> saveImgPathToLocalData();

  Future<void> removeImgPathFromLocalData();
}

class UserViewModel with ChangeNotifier implements BaseUserViewModel {
  late final LocalDataManager _localDataManager;

  UserViewModel() {
    _localDataManager = LocalDataManager.getInstance();
  }

  String _filePath = '';

  String get filePath => _filePath;

  // get the img path from local data manager
  @override
  Future<void> getImgPathFromLocalData() async {
    _filePath = await _localDataManager.getImgPath();
  }

  set filePath(String value) => _filePath = value;

  @override
  Future<void> removeImgPathFromLocalData() async {
    _filePath = '';
    await _localDataManager.removeImgPath();
  }

  @override
  Future<void> saveImgPathToLocalData() async {
    await _localDataManager.saveImgPath(_filePath);
  }
}
