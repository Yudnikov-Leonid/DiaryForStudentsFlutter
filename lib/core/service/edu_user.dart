import 'package:shared_preferences/shared_preferences.dart';

class EduUser {
  final SharedPreferences pref;
  EduUser(this.pref);

  void save(String email, String fullName, String guid, String apikey,
      String school, String grade) {
    pref.setString(_emailKey, email);
    pref.setString(_fullNameKey, fullName);
    pref.setString(_guidKey, guid);
    pref.setString(_apikeyKey, apikey);
    pref.setString(_schoolKey, school);
    pref.setString(_gradeKey, grade);
  }

  String email() => pref.getString(_emailKey) ?? '';
  String fullName() => pref.getString(_fullNameKey) ?? '';
  String guid() => pref.getString(_guidKey) ?? '';
  String apikey() => pref.getString(_apikeyKey) ?? '';
  String school() => pref.getString(_schoolKey) ?? '';
  String grade() => pref.getString(_gradeKey) ?? '';

  void logOut() {
    pref.clear();
  }

  final _emailKey = 'email_key';
  final _fullNameKey = 'full_name_key';
  final _guidKey = 'guid_key';
  final _apikeyKey = 'apikey_key';
  final _schoolKey = 'school_key';
  final _gradeKey = 'grade_key';
}
