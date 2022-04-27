import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassswordController =
      new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Isi terlebih dahulu semua input');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Password tidak sama');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(context, 'Password setidaknya memiliki 6 karakter');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, 'Pilih gambar terlebih dahulu');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Sedang Mengupload');
    isEnable = false;
    User user = new User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password);

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('RESPONSE: ${responseApi.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      } else {
        isEnable = false;
      }

      print('Response: ${responseApi.toJson()}');
    });
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALLERY'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMERA'));

    AlertDialog alertDialog = AlertDialog(
        title: Text('Pilih gambar'), actions: [galleryButton, cameraButton]);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
