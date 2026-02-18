import 'package:ai_app/etc/error_presentation/failures/shared_prefs_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ItemName { ip }

class SharedPrefsDatabase {
  final SharedPreferences _prefs;
  SharedPrefsDatabase(this._prefs);

  static const _ipRepo = "ip";

  Result get getIp {
    try {
      final result = _prefs.getString(_ipRepo);
      return result != null
          ? Ok(result)
          : Err(SharedPrefsFailure(SharedPrefsFailureType.unknown, message: "not found"));
    } catch (e) {
      return Err(SharedPrefsFailure(SharedPrefsFailureType.unknown));
    }
  }

  Future<Result> setIp(String ip) async {
    try {
      final result = await _prefs.setString(_ipRepo, ip);
      return result == true ? const Ok(Unit) : Err(SharedPrefsFailure(SharedPrefsFailureType.unknown));
    } catch (e) {
      return Err(SharedPrefsFailure(SharedPrefsFailureType.unknown));
    }
  }
}
