import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/Couponsview.dart';

class CouponCardView extends StatelessWidget {
  final CouponView viewModel;

  const CouponCardView({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: viewModel.couponsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Quelque chose s'est mal passé");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("Aucun coupon disponible"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return CouponCard(document: document);
          },
        );
      },
    );
  }
}
class CouponCard extends StatelessWidget {
  final DocumentSnapshot document;

  CouponCard({required this.document, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the date from the document
  DateTime expirationDate = DateTime.parse(document['expiryDate']);
  DateTime debitDate = DateTime.parse(document['debitDate']);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        title: Text(document['title'].toString(),style: TextStyle(
            fontWeight: FontWeight.bold, 
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
              document['description'].toString(),
              style: TextStyle(
                fontSize: 20, 
              ),
            ),
            SizedBox(height: 10.0),
                  Text("Date debit: ${DateFormat('dd/MM/yyyy').format(debitDate)}",
              style: TextStyle(
                fontSize: 16,color: Colors.black,
              ),),
                  SizedBox(height: 8),
                  Text("Date d'expiration: ${DateFormat('dd/MM/yyyy').format(expirationDate)}",
              style: TextStyle(
                fontSize: 16, color: Colors.black,
              ),),
          ],
        ),
        
      ),
    );
  }
}
