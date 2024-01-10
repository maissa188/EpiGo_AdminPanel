import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/services/firebase.dart';

class CouponView {
   final FirebaseServices _services = FirebaseServices();
  Stream<QuerySnapshot> get couponsStream =>
      _services.coupons.orderBy('title', descending:false).snapshots();
}
