import 'package:grocery/export.dart';

class UserProvider extends ChangeNotifier {
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userPhoneKey = 'user_phone';
  static const String _isLoggedInKey = 'is_logged_in';

  String _userName = 'Guest User';
  String _userEmail = '';
  String _userPhone = '';
  bool _isLoggedIn = false;

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  bool get isLoggedIn => _isLoggedIn;

  UserProvider() {
    _loadUserData();
  }

  void setUser(String name, String email, String phone) async {
    _userName = name;
    _userEmail = email;
    _userPhone = phone;
    _isLoggedIn = true;
    notifyListeners();
    await _saveUserData();
  }

  void logout() async {
    _userName = 'Guest User';
    _userEmail = '';
    _userPhone = '';
    _isLoggedIn = false;
    notifyListeners();
    await _clearUserData();
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString(_userNameKey) ?? 'Guest User';
    _userEmail = prefs.getString(_userEmailKey) ?? '';
    _userPhone = prefs.getString(_userPhoneKey) ?? '';
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, _userName);
    await prefs.setString(_userEmailKey, _userEmail);
    await prefs.setString(_userPhoneKey, _userPhone);
    await prefs.setBool(_isLoggedInKey, _isLoggedIn);
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userPhoneKey);
    await prefs.remove(_isLoggedInKey);
  }
}