import 'package:cloud_firestore/cloud_firestore.dart';

class SellerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSellersStream() {
    return _firestore.collection('sellers').snapshots();
  }
}