import 'package:flutter/cupertino.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<dynamic> _productPhoto = [];

  List<ProductModel> get products => _products;
  List get productPhotos => _productPhoto;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  set productPhotos(List productPhoto) {
    _productPhoto = productPhoto;
    notifyListeners();
  }

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
    } catch (e) {
      print(e);
    }
  }
}

void main() {
  // ProductProvider productProvider = Provider.of<ProductProvider>(context);
}
