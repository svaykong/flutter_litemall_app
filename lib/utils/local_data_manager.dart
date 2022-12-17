import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  const LocalDataManager._();

  // storing imgPath
  static const _imgPathKey = 'imgPath';

  static LocalDataManager getInstance() {
    return const LocalDataManager._();
  }

  // save img path to the local storage
  Future<bool> saveImgPath(String imgPath) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_imgPathKey, imgPath);
  }

  // remove img path from the local storage
  Future<bool> removeImgPath() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_imgPathKey);
  }

  // get img path from the local storage
  Future<String> getImgPath() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(_imgPathKey);
    if (result == null) {
      return '';
    } else {
      return result;
    }
  }
}
