import 'dart:convert';

import 'package:ecommerce/class/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepo extends StateNotifier<User> {
  static UserRepo? userRepoInstance;
  static User user = User();
  UserRepo._() : super(user);

  static UserRepo getInstance() {
    return userRepoInstance ??= UserRepo._();
  }

  void setUser(int id) {
    print('id : $id');
    state.id = id;
  }

  Future<int> register(String email, String password) async {
    http.Response response = await _postRequest(
        'http://localhost:8082/api/register', email, password);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as int;
    } else {
      throw Exception('Failed');
    }
  }

  Future<int> login(String email, String password) async {
    http.Response response =
        await _postRequest('http://localhost:8082/api/login', email, password);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as int;
    } else {
      throw Exception('Failed');
    }
  }

  Future<http.Response> _postRequest(
      String url, String email, String password) async {
    return await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }
}
