import 'dart:async';

import 'package:fboilerplate/apis/base_api.dart';
import 'package:fboilerplate/apis/models/user/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticateApi extends BaseApi {
  Future<User> login({
    String username,
    String password,
  }) async {
    final url = 'authenticate/login?username=$username&password=$password';
    final user = await getData(url, User());
    return user;
  }
}
