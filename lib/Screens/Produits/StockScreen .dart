import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class StockScreen extends StatefulWidget  {
static const String id = 'stock-screen';

  State<StockScreen> createState() => _StockScreenState();


 String get selectedFournisseur => selectedFournisseur;
  bool get  _isFournisseurSelected => _isFournisseurSelected;
  }
 

class _StockScreenState extends State<StockScreen> {
DateTime selectedDate = DateTime.now();
    String selectedFournisseur="0";
     bool _isFournisseurSelected=false;
      String selectedProduit="0";
     bool _isProduitSelected=false;
var dateText = TextEditingController();
var dateT = TextEditingController();
var stock = TextEditingController();
 
List<String> availableUnits = ["kg", "pcs"];
String selectedUnit = ''; 
 DateTime _selectedDate = DateTime.now();

  void initState(){
  dateText= TextEditingController();
   dateT= TextEditingController();
stock = TextEditingController();

    super.initState();
   } 


void _updateStock() async {
  if (selectedProduit != "0" && selectedFournisseur != "0") {
    try {
      String stockId = FirebaseFirestore.instance.collection('stock').doc().id;
      await FirebaseFirestore.instance.collection('stock').doc(stockId).set({
        'id': stockId,
        'produit': selectedProduit,
        'fournisseur': selectedFournisseur,
        'date_commande': dateText.text,
        'date_reception': dateT.text,
        'quantity': double.parse(stock.text),
        'unit': selectedUnit,
      });
   print('Selected Product ID: $selectedProduit');
  DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
      .collection('products')
      .where('title', isEqualTo: selectedProduit) 
      .get()
      .then((QuerySnapshot querySnapshot) => querySnapshot.docs.first);

  if (productSnapshot.exists) {
    String productId = productSnapshot.id;
    await FirebaseFirestore.instance.collection('products')
        .doc(productId)  // Use the obtained ID here
        .update({
          'stockQuantity': FieldValue.increment(double.parse(stock.text)),
        });

        // Display a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Données stockées avec succès.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Display a message if the product document doesn't exist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product not found in Firestore.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error storing data in Firestore.'),
          duration: Duration(seconds: 2),
        ),
      );
      print(error);
    }
  } else {
    // Display a message if all conditions are not met
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Veuillez remplir tous les champs correctement.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

_selectDate(context)async{
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
     firstDate: DateTime.now(), 
     lastDate: DateTime(2050),
     );
     if (picked!= null && picked != _selectedDate){
      setState(() {
      _selectedDate = picked;
      String formattedText = DateFormat('yyyy-MM-dd').format(_selectedDate);
      dateText.text =formattedText;
    });
     }
}

_selecteDate(context)async{
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
     firstDate: DateTime.now(), 
     lastDate: DateTime(2050),
     );
     if (picked!= null && picked != _selectedDate){
      setState(() {
      _selectedDate = picked;
      String formattedText = DateFormat('yyyy-MM-dd').format(_selectedDate);
      dateT.text =formattedText;
    });
     }
}

  @override
  Widget build(BuildContext context) {
   SideBarwidget _sideBar = SideBarwidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 189, 154),
        title: const Text('Epi Go Dashboard',style: TextStyle(color:Colors.white,),),
      ),
      sideBar: _sideBar.sideBarMenus(context,StockScreen.id),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
               const Text(
                        'Alimenter le stock',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                     SizedBox(height: 50.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 220.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: dateText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le titre est obligatoire';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(),
                                labelText: 'Date de commande',
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Icon(Icons.date_range_outlined),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50.0,),
                           SizedBox(
                            width: 220.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: dateT,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Le titre est obligatoire';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(),
                                labelText: 'Date de réception',
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selecteDate(context);
                                  },
                                  child: Icon(Icons.date_range_outlined),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),

                      Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(8.0)),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('products').orderBy('title',descending: true).snapshots(),
                                builder: (context, snapshot) {
                                  List<DropdownMenuItem> produitItems = [];
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    final products = snapshot.data?.docs.reversed.toList();
                                    produitItems.add(
                                      const DropdownMenuItem(
                                        value: "0",
                                        child: Text('Produit '),
                                      ),
                                    );
                                    for (var category in products!) {
                                      produitItems.add(DropdownMenuItem(
                                        value: category["title"],
                                        child: Text(category['title']),
                                      ));
                                    }
                                  }
                                  return DropdownButton(
                                    items: produitItems,
                                    onChanged: (produitValue) {
                                      setState(() {
                                        selectedProduit = produitValue;
                                       _isProduitSelected = true;
                                      });
                                    },
                                    value: selectedProduit,
                                    isExpanded: false,
                                    hint: Text('Sélectionner un produit'),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(width: 80), // Adjust the spacing as needed
               
                          // Supplier selection
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(16.0)),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('fournisseurs').snapshots(),
                                builder: (context, snapshot) {
                                  List<DropdownMenuItem> fournisseurItems = [];
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    final fournisseurs = snapshot.data?.docs.reversed.toList();
                                    fournisseurItems.add(
                                      const DropdownMenuItem(
                                        value: "0",
                                        child: Text('Fournisseur'),
                                      ),
                                    );
                                    for (var fournisseur in fournisseurs!) {
                                      fournisseurItems.add(DropdownMenuItem(
                                        value: fournisseur["name"],
                                        child: Text(fournisseur['name']),
                                      ));
                                    }
                                  }
                                  return DropdownButton(
                                    items: fournisseurItems,
                                    onChanged: (fournisseurValue) {
                                      setState(() {
                                        selectedFournisseur = fournisseurValue;
                                        _isFournisseurSelected = true;
                                      });
                                    },
                                    value: selectedFournisseur,
                                    isExpanded: false,
                                    hint: Text('Sélectionner un Fournisseur'),
                                  );
                                },
                              ),
                            ],
                          ),
                       
                      
           
                        ],
                      ),
           
                           SizedBox(height: 16.0),
Row(
      children: [
     
         const Text(
                          'Unité  :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: availableUnits.map((unit) {
                            return Row(
                              children: [
                                Radio(
                                  value: unit,
                                  groupValue: selectedUnit,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedUnit = value.toString();
                                    });
                                  },
                                ),
                                Text(unit),
                                const SizedBox(width: 10),
                              ],
                            );
                          }).toList(),
                          
                        ),
                         
        SizedBox(width: 50.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 200.0,
                                        child: TextField(
                                          controller: stock,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(labelText: 'Quantité '),
                                        ),
                                      ),
                            ],
                          ),
      ],
      
    ),


            
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () {
                  _updateStock();
                },
                child: Text('Alimenter '),
              ),
            ],
          ),
          
        ),
        
      ),   );
  }
}
