import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  const LocalDataManager._();

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

// save selected beers
// Future<bool> saveSelectedBeers(Set<String> selectedBeers) async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return await prefs.setStringList(_beersKey, selectedBeers.toList());
// }

// get selected beers
// Future<List<String>?> getSelectedBeers() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return prefs.getStringList(_beersKey);
// }

// remove selected beers
// Future<bool> removeSelectedBeers() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return await prefs.remove(_beersKey);
// }

// save latest beer index
// Future<bool> saveLatestBeerIndex(int index) async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return await prefs.setInt(_latestBeerKey, index);
// }

// get latest beer index
// Future<int?> getLatestBeerIndex() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return prefs.getInt(_latestBeerKey);
// }

// remove latest beer index
// Future<bool> removeLatestBeerIndex() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return await prefs.remove(_latestBeerKey);
// }

// delete all the data
// Future<bool> clearAllData() async {
//   final prefs = await SharedPreferences.getInstance();
//
//   return prefs.clear();
// }
}
