import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  late String id;
  late String title;
  late int discount;
  late String? expiryDate;
    late String? debitDate;
  late String description;
  late bool? isActivated;

  CouponModel({
    required this.id,
    required this.title,
    required this.discount,
    this.expiryDate,
    this.debitDate,
    required this.description,
    this.isActivated,
  });

  factory CouponModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return CouponModel(
      id: doc.id,
      title: data['title'],
      discount: data['discount'],
      expiryDate: data['expiryDate'],
      debitDate: data['debitDate'],
      description: data['description'],
      isActivated: data['isActivated'],
    );
  }

  CouponModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    discount = map['discount'];
    expiryDate = map['expiryDate'];  
    debitDate = map['debitDate']; 
    description = map['description'];
    isActivated = map['isActivated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'discount': discount,
      'expiryDate': expiryDate,
      'debitDate': debitDate,
      'description': description,
      'isActivated': isActivated,
    };
  }
}
