import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery_udemy/src/models/category.dart';
import 'package:flutter_delivery_udemy/src/pages/restaurant/products/create/restaurant_products_controller.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';

class RestaurantCreateProductsPage extends StatefulWidget {
  const RestaurantCreateProductsPage({Key key}) : super(key: key);

  @override
  State<RestaurantCreateProductsPage> createState() =>
      _RestaurantCreateProductsPageState();
}

class _RestaurantCreateProductsPageState
    extends State<RestaurantCreateProductsPage> {
  RestaurantCreateProductsController _con =
      new RestaurantCreateProductsController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Produk Baru')),
      body: ListView(
        children: [
          _textFieldProductName(),
          _textFieldCategoryDescription(),
          _textFieldProductPrice(),
          Container(
            height: 75,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3)
              ],
            ),
          ),
          _dropDownCategories(_con.categories),
        ],
      ),
      bottomNavigationBar: _buttonCategoriesCreate(),
    );
  }

  Widget _textFieldProductName() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(5)),
      child: TextField(
        maxLines: 1,
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nama Produk Anda',
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 15, 15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.local_pizza_rounded,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldProductPrice() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(5)),
      child: TextField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        controller: _con.priceController,
        decoration: InputDecoration(
            hintText: 'Harga Produk',
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 15, 15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(
              Icons.monetization_on_sharp,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldCategoryDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.only(top: 10, left: 5, right: 7, bottom: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          TextField(
            controller: _con.descriptionController,
            maxLines: 5,
            maxLength: 180,
            decoration: InputDecoration(
              hintText: 'Deskripsi Produk Anda',
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(27, 10, 5, 20),
              hintStyle: TextStyle(color: MyColors.primaryColorDark),
            ),
          ),
          Positioned(
              left: 2,
              top: 7,
              child: Icon(
                Icons.description,
                color: MyColors.primaryColor,
              )),
        ],
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.search, color: MyColors.primaryColor),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Kategori-kategori',
                      style: TextStyle(color: Colors.grey, fontSize: 16))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down_circle,
                        color: MyColors.primaryColor,
                      ),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text('Pilih Kategori',
                        style: TextStyle(color: Colors.grey, fontSize: 15)),
                    items: _dropMenuItems(categories),
                    value:_con.idCategory,
                    onChanged: (option){
                      print('an category $option');
                      setState(() {
                        _con.idCategory=option;// variabel of id category
                        });
                    },
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }


  List<DropdownMenuItem<String>> _dropMenuItems(List<Category> categories){
    List<DropdownMenuItem<String>> list =[];
    categories.forEach((category) {
      list.add(DropdownMenuItem(child: Text(category.name),value:category.id));
    });

    return list;
  }

  Widget _cardImage(File imageFile, int numberFile) {
    return GestureDetector(
      onTap:(){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: Container(
                height: 75,
                width: MediaQuery.of(context).size.width * 0.255,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Card(
              elevation: 3.0,
              child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.255,
                  child: Image(
                    height: 70,
                    image: AssetImage('assets/img/add_image.png'),
                    fit: BoxFit.contain,
                  ))),
    );
  }

  Widget _buttonCategoriesCreate() {
    return Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        child: Text('TAMBAH PRODUK BARU'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
