import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/services/firebase.dart';

class StockView {
   final FirebaseServices _services = FirebaseServices();

  Stream<QuerySnapshot> get fournisseursStream =>
      _services.stock.orderBy('date_commande', descending: true).snapshots();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
}