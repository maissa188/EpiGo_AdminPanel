

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/stock_view.dart';

class StockDataTable extends StatelessWidget {
  final StockView viewModel;

  const StockDataTable({required this.viewModel, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
 
    return StreamBuilder(
      stream: viewModel.stockStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Quelque chose s'est mal passé");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            dataRowHeight: 60,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: <DataColumn>[
            
              DataColumn(label: Text('Date commande')),
          
             DataColumn(label: Text('Date réception')),
              DataColumn(label: Text('Produit')),
              DataColumn(label: Text('Fournisseur')),
                 DataColumn(label: Text('Quantité')),
              DataColumn(label: Text('Action')),
             
            ],
            // details
            rows: _vendorDetailsRows(snapshot.data, context),
             columnSpacing: 80, // Add space between columns
          ),
        );
      },
    );
  }

  

    List<DataRow> _vendorDetailsRows(
      QuerySnapshot? snapshot, BuildContext context) {
    if (snapshot == null || snapshot.docs.isEmpty) {
      return [];
    }

    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      List<DataCell> cells = _extractCells(document, context);
      return DataRow(cells: cells);
    }).toList();

    return newList;
  }
List<DataCell> _extractCells(DocumentSnapshot document,  BuildContext context) {
   StockView viewModel = this.viewModel;
  return [
    DataCell(Text(document['date_commande'].toString())),
    DataCell(Text(document['date_reception'].toString())),
    DataCell(Text(document['produit'].toString())),
    DataCell(Text(document['fournisseur'].toString())),
     DataCell(Text(document['quantity'].toString())),
    DataCell(Row(
  children: [
    IconButton(
      icon: Icon(Icons.visibility),  
      onPressed: () {
        
      },
    ),
    IconButton(
      icon: Icon(Icons.edit),  
      onPressed: () {
       
      },
    ),
   
  ],
)),

   
  ];
}

}