import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shamo/models/gallery_model.dart';
import 'package:shamo/models/product_model.dart';

void main() async {
  List number = [1, 2, 3, 4, 5, 6, 7];

  List dataNumber = [];

  number.map((numb) {
    dataNumber.add(numb);
  }).toList();

  // print(dataNumber);

  Future<List<dynamic>> getFirstPhotoUrlProduct() async {
    String baseUrl = "https://shamo-backend.buildwithangga.id/api";
    var url = Uri.parse("$baseUrl/products");
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    var data = jsonDecode(response.body)['data']['data'];
    // print(data);

    List<ProductModel> products = [];
    for (var item in data) {
      products.add(ProductModel.fromJson(item));
    }

    List dataShoes = [];

    products.map((product) {
      dataShoes.add(product.galleries?[0]?.url);
    }).toList();
    // print("Final data => ");
    // print(dataShoes.runtimeType);
    return dataShoes;
  }

  // print(getProduct());

  // var dataShoes = getProduct();
  // print(dataShoes.runtimeType);
  // Future<List> dataSepatu = getProduct();
  // List list = await dataSepatu;
  // print(list);
  List<dynamic> _productPhoto = [];

  Future<void> getPhotoProduct() async {
    try {
      List<dynamic> products = await getFirstPhotoUrlProduct();
      _productPhoto = products;
      // _productPhoto.add(products);
      // print(_productPhoto);
    } catch (e) {
      print(e);
    }
  }

  // List get jumlah =>  _productPhoto;

  // List data = getPhotoProduct();
  // void data = await getPhotoProduct();
  // print("Hasil final => ");
  // print(data.);
}
