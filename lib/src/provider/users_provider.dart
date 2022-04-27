import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/api/environment.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<Stream> createWithImage(User user, File image) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("http://192.168.43.12:5456/api/users/create"));

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
      var url = 'http://192.168.43.12:5456/api/users/create';
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
      var url = 'http://192.168.43.12:5456/api/users/login';
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
}
