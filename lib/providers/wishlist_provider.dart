import 'package:flutter/cupertino.dart';
import 'package:shamo/models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishList = [];

  List<ProductModel> get wishList => _wishList;

  set wishlist(List<ProductModel> wishlist) {
    _wishList = wishlist;
    notifyListeners();
  }

  setProduct(ProductModel product) {
    if (!isWishlist(product)) {
      // jika tidak ada di dalam wishlist, => tambahkan
      _wishList.add(product);
    } else {
      // jika ada datanya di dalama wishlist => remove
      _wishList.removeWhere((element) => element.id == product.id);
    }

    notifyListeners();
  }

// pengecekan terlebih dahulu apakah si product sudah tersedia di wishlist apa tidak
// jika ada, kurangi productnya/menghilangkannya dari wishlist
// jika tidak ada, tambahkan ke wishlist tersebu
  isWishlist(ProductModel product) {
    if (_wishList.indexWhere((element) => element.id == product.id) == -1) {
      // jika index bernilai -1 atau tidak ada product di dalam wishlist => return false
      return false;
    } else {
      // jika tidak => return true
      return true;
    }
  }
}
