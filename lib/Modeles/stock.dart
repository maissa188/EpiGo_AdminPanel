import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  late String id;
  late String product;
  late String? datec;
  late String? date;
 late String? fournisseur;
 late int? quantity;
  late String unit;

Stock(Map<String, Object> map, {
    required this.id,
    required this.product,
    required this.unit,
    this.quantity,
   this.fournisseur,
   this.date,
   this.datec,

  });

 Stock.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
  id = snapshot.id;
product = snapshot['product'];
  unit = snapshot['unit'];
  date = snapshot['date'];
  datec = snapshot['datec'];
  quantity = snapshot['quantity']; 
  fournisseur = snapshot['fournisseur'];
}

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    product = map['product'];
    unit = map.containsKey('unit') ? map['unit'] ?? 'DefaultUnit' : 'DefaultUnit';
    quantity = map['quantity'];
    datec  = map['datec'];
    date = map['date'];
    fournisseur = map['fournisseur'];
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'product': product,
        'date' :date,
        'datec' : datec,
        'unit': unit,
        'quantity': quantity,
        'fournisseur': fournisseur,    
      };
}