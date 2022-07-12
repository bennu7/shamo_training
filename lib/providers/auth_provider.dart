import 'package:flutter/material.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  // buat getter dan setter
  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // function untuk melakukan register, dengan mengembalikan nilai hasil boolean, apakah registrasi berhasil atau tidak
  Future<bool> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      // jika berhasil, simpan ke data baru _user
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    @required String? email,
    @required String? password,
  }) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);

      // jika berhasil, simpan ke data baru _user
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
