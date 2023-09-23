import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:newtronic_banking/data/model/user_model.dart';

class Repository {
  Future<List<Users>> getUsers() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/user.json');
    final data = await json.decode(response)['users'];
    final List<Users> users = [];
    for (var i = 0; i < data.length; i++) {
      users.add(Users.fromJson(data[i]));
    }
    return users;
  }

  Future<Users?> loginUser({
    required emailOrUsername,
    required password,
  }) async {
    final List<Users> users = await getUsers();
    Users? user;
    for (var i = 0; i < users.length; i++) {
      if (users[i].email == emailOrUsername ||
          users[i].username == emailOrUsername) {
        if (users[i].password == password) {
          user = users[i];
        }
      }
    }
    return user;
  }
}
