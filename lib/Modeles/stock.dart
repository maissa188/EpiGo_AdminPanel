import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  late String id;
  late String product;
  late String? date_commande;
  late String? date_reception;
 late String? fournisseur;
 late double? quantity;
  late String unit;

Stock(Map<String, Object> map, {
    required this.id,
    required this.product,
    required this.unit,
    this.quantity,
   this.fournisseur,
   this.date_commande,
   this.date_reception,

  });

 Stock.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
  id = snapshot.id;
product = snapshot['product'];
  unit = snapshot['unit'];
  date_commande= snapshot['date_commande'];
  date_reception = snapshot['date_reception'];
  quantity = snapshot['quantity']; 
  fournisseur = snapshot['fournisseur'];
}

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    product = map['product'];
    unit = map.containsKey('unit') ? map['unit'] ?? 'DefaultUnit' : 'DefaultUnit';
    quantity = map['quantity'];
    date_commande  = map['date_commande'];
    date_reception = map['date_reception'];
    fournisseur = map['fournisseur'];
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'product': product,
        'date_commande' :date_commande,
        'date_reception' : date_reception,
        'unit': unit,
        'quantity': quantity,
        'fournisseur': fournisseur,    
      };
}