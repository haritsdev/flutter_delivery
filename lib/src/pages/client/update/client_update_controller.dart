import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/models/response_api.dart';
import 'package:flutter_delivery_udemy/src/models/user.dart';
import 'package:flutter_delivery_udemy/src/provider/users_provider.dart';
import 'package:flutter_delivery_udemy/src/utils/my_snackbar.dart';
import 'package:flutter_delivery_udemy/src/utils/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientUpdateController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  ProgressDialog _progressDialog;

  bool isEnable = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context, sessionUser: user);
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));

    emailController.text = user.email;
    nameController.text = user.name;
    lastnameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  void updateProfile() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Isi terlebih dahulu semua input');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Sedang Mengupload');
    isEnable = false;
    User myUser = new User(
        id: user.id,
        email: user.email,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user.image);

    Stream stream = await usersProvider.updateProfile(myUser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(
          msg: responseApi.message,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green[300],
          textColor: Colors.white,
          fontSize: 16.0);
      if (responseApi.success) {
        user = await usersProvider.getById(myUser.id); // * CALL BACKEND API
        _sharedPref.save('user', user.toJson());
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/products/list', (route) => false);
        });
      } else {
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Fluttertoast.showToast(
            msg: responseApi.message,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            fontSize: 16.0);
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
