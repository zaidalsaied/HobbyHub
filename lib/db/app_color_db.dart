import 'package:hive/hive.dart';

class AppColorDB {
  static var appColorDB;

  Future<void> openAppColorDbBox() async {
    try {
      appColorDB = await Hive.openBox<int>("appColorDB");
    } catch (e) {
      print("appColorDB openAppColorDbBox ERROR:$e");
      return;
    }
  }

  void saveAppColor(int colorIndex) {
    try {
      appColorDB.put('app-color', colorIndex);
    } catch (e) {
      print(e);
      print("AppColorDB saveAppColor ERROR:$e");
    }
  }

  int getAppColor() {
    try {
      return appColorDB.get('app-color');
    } catch (e) {
      print("AppColorDb getAppColor ERROR:$e");
      return null;
    }
  }
}
