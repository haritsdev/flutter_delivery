import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider {
  String domain = 'http://192.168.43.12:5456';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, {User sessionUser}) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<User> getById(String id) async {
    try {
      var myUrl = '$domain/api/user/findById/$id';
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 401) {
        //* UNAUTORIZED USERS
        Fluttertoast.showToast(msg: 'Session token expired');
        new SharedPref().logout(context, sessionUser.id);
      }
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Stream> createWithImage(User user, File image) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse("$domain/api/users/create"));

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      // Uri url = Uri.http(_url, '$_api/create');
      var url = '$domain/api/users/create';
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      // Uri url = Uri.http(_url, '$_api/create');
      var url = '$domain/api/users/login';
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> logout(String idUser) async {
    try {
      // Uri url = Uri.http(_url, '$_api/create');
      var url = '$domain/api/users/logout';
      String bodyParams = json.encode({'id': idUser});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream> updateProfile(User user, File image) async {
    try {
      print('hfdfffffffffffffffffffffffffffffff');
      final request = http.MultipartRequest(
          'PUT', Uri.parse("$domain/api/user/update-profile"));
      request.headers['Authorization'] = sessionUser.sessionToken;
      Fluttertoast.showToast(msg: 'Berhasil');

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }
      print('=============hallo sayang==============');
      // request.fields['user'] = json.encode(user);
      // final response = await request.send();
      // if (response.statusCode == 401) {
      //   Fluttertoast.showToast(msg: 'Session token expired');
      //   new SharedPref().logout(context, sessionUser.id);
      // }
      // return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
