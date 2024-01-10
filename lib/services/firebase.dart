import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Modeles/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference banners = FirebaseFirestore.instance.collection('banners');
  Query<Map<String, dynamic>> produits = FirebaseFirestore.instance.collection('products').orderBy('title',descending: false);
    CollectionReference fournisseurs = FirebaseFirestore.instance.collection('fournisseurs');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
     CollectionReference deliveryMethods = FirebaseFirestore.instance.collection('deliveryMethods');
         CollectionReference stock= FirebaseFirestore.instance.collection('stock');
          CollectionReference coupons= FirebaseFirestore.instance.collection('coupons');


  Future<QuerySnapshot> getAdminCredentials(){
var result = FirebaseFirestore.instance.collection('Admin').get();
return result;
  }

  
Stream<List<Product>> searchProduct(String searchText) {
    return _firestore
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: searchText.toUpperCase())
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }
  //vendors
  updateVendorStatus({id,status})async{
    fournisseurs.doc(id).update({
      'accVerified':status?false:true
    });
  }
  
}