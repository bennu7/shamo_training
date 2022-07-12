import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shamo/models/category_model.dart';

import '../models/product_model.dart';

class ProductService {
  String baseUrl = "https://shamo-backend.buildwithangga.id/api";

  Future<List<ProductModel>> getProducts() async {
    var url = "$baseUrl/products";
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Get Product');
    }
  }

  Future<List<dynamic>> getFirstPhotoUrlProduct() async {
    var url = Uri.parse("$baseUrl/products");
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 20) {
      var data = jsonDecode(response.body)['data']['data'];
      // print(data);

      List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      List dataShoes = [];

      products.map((product) {
        dataShoes.add(product.galleries?[0].url);
      }).toList();
      print(dataShoes);
      return dataShoes;
    } else {
      throw Exception('Gagal Get Product FirstPhotoUrl');
    }
  }
}
