import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = "https://shamo-backend.buildwithangga.id/api";

  Future<UserModel> register({
    @required String? name,
    @required String? username,
    @required String? email,
    @required String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    //* perlu melakukan encode pada json ini
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // decode kembali ketika mengirimkan data ke server
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      // untuk tokennnya gi gabung token type & access_token
      user.token = data['token_type'] + ' ' + data['access_token'];

      print("response body => ${response.body}");
      print("token => ${user.token}");

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    @required String? email,
    @required String? password,
  }) async {
    var url = '$baseUrl/login';

    var headers = {'Content-Type': 'application/json'};
    //* perlu melakukan encode pada json ini
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      // untuk tokennnya gi gabung token type & access_token
      user.token = data['token_type'] + ' ' + data['access_token'];

      print("response body => ${response.body}");
      print("token => ${user.token}");

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
