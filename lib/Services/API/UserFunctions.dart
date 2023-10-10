import 'dart:convert';
import 'package:db_project/Services/API/API_Operation.dart';
import 'package:db_project/Services/User.dart';
import 'package:http/http.dart';

class UserFunctions extends APIOperation {
  bool status = false;

  Future addUser(User user) async {
    Response response = await super.post("url", user.toMap());
    if (response.statusCode == 200) {
      status = true;
    } else {
      print(jsonDecode(response.body)['message']);
      status = false;
    }
  }

  Future updateUser(int id, User user) async {
    Response response = await super.put("url/$id", user.toMap());
    if (response.statusCode == 200) {
      status = true;
    } else {
      print(jsonDecode(response.body)['message']);
      status = false;
    }
  }

  Future deleteUser(int id) async {
    Response response = await super.delete("url/$id");
    if (response.statusCode == 200) {
      status = true;
    } else {
      print(jsonDecode(response.body)['message']);
      status = false;
    }
  }

  Future<List<User>> getUsers() async {
    Response response = await super.fetchAll("url");
    List users = jsonDecode(response.body)['data'];
    return List.generate(
        users.length,
        (index) => User(
            username: users[index]['username'],
            id: users[index]['id'],
            password: users[index]['password']));
  }
}