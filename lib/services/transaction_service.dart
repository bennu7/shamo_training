import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = "https://shamo-backend.buildwithangga.id/api";

  Future<bool> checkOut(
      String token, List<CartModel> carts, double totalPrice) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'address': 'Kota Mataram',
      'items': carts
          .map(
            (cart) => {
              'id': cart.product!.id,
              'quantity': cart.quantity,
            },
          )
          .toList(),
      'status': 'PENDING',
      "total_price": totalPrice,
      "shipping_price": 0,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print("value /post checkout => " + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal checkout');
    }
  }
}
