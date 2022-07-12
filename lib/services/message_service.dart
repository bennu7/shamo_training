import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMessage(
      {UserModel? user,
      bool? isFromUser,
      String? message,
      ProductModel? product}) async {
    try {
      // membuat collection
      firestore.collection('message').add({
        'userId': user!.id,
        'userName': user.name,
        'userImage': user.profilePhotoUrl,
        // karena ini merupakan service untuk client, jadikan isfromUser bernilai true
        'isFromUser': isFromUser,
        'message': message,
        'product':
            product is UninitializedProductModel ? {} : product!.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      }).then((value) => print("Pesan berhasil dikirim! and value => $value"));
    } catch (e) {
      throw Exception('Pesan gagal dikirim');
    }
  }
}
