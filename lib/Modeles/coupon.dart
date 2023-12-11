class Coupon {
     late String? id;
     late String title;
     late double discount;
     late String expiryDate;
    late String description;
    late bool? isAvtivated;

Coupon({
    this.id,
    required this.title,
     required this.discount,
    required this.expiryDate,
    required this.description,
    this.isAvtivated,

});
Coupon.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    title = snapshot['title'];
    discount = snapshot['discount'];
    expiryDate= snapshot['expiryDate'];
    description = snapshot['description'];
    isAvtivated = snapshot['isAvtivated'];
   

  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'title ': title ,
        'discount': discount,
        'expiryDate': expiryDate,
        'description': description,
        'isAvtivated ':isAvtivated ,
      
      };

}