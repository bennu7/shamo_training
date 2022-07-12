import 'package:flutter/cupertino.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (productExist(product)) {
      // jika ada product, cari indexnya
      int index =
          _carts.indexWhere((element) => element.product!.id == product.id);
      //_carts[index].quantity!++; => it's not working, alternatif di bawah
      _carts[index].quantity = _carts[index].quantity! + 1;
    } else {
      // jika productnya tidak ada, tambahkan dengan model CartModel
      _carts.add(CartModel(
        id: _carts.length,
        product: product,
        // quantity mulai dari 1
        quantity: 1,
      ));
    }

    notifyListeners();
  }

  // function untuk menghapus cart product
  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addQuantity(int id) {
    // _carts[id].quantity++; => it's not working
    _carts[id].quantity = _carts[id].quantity! + 1;
    notifyListeners();
  }

  reduceQuantity(int id) {
    // _carts[id].quantity!--;
    _carts[id].quantity = _carts[id].quantity! - 1;
    // lakukan pengkondisian agar nilai tidak minus value nya dari 0
    if (_carts[id].quantity == 0) {
      // jika sudah mencapai angka 0, remove cart nya
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  // function untuk menghitung barang
  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity!;
    }

    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity!.toDouble() * item.product!.price!.toDouble());
    }
    return total;
  }

  // pengecekan apakah product sudah tersedia di di cart atau belum => sama seperti wishlist
  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      // jika tidak ada product
      return false;
    } else {
      return true;
    }
  }
}
