import 'package:flutter/cupertino.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<dynamic> _productPhoto = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  // set productPhotos(List productPhoto) {
  //   _productPhoto = productPhoto;
  //   notifyListeners();
  // }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPhotoProduct() async {
    try {
      List<dynamic> productPhotos =
          await ProductService().getFirstPhotoUrlProduct();
      _productPhoto = productPhotos;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> get productPhotos => _productPhoto;
}
