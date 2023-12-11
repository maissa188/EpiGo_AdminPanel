// ignore_for_file: camel_case_types, file_names, sort_child_properties_last, prefer_const_constructors

import 'package:epigo_adminpanel/Screens/Produits/StockScreen.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:epigo_adminpanel/services/stock_view.dart';
import 'package:epigo_adminpanel/widgets/fournisseur_datatable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
class Addcoupon_Screen extends StatefulWidget {
    static const String id = 'coupon-screen';
  const Addcoupon_Screen({super.key});

  @override
  State<Addcoupon_Screen> createState() => _Addcoupon_ScreenState();
}

class _Addcoupon_ScreenState extends State<_Addcoupon_Screen> {
DateTime selectedDate = DateTime.now();
   
var dateText = TextEditingController();
var title = TextEditingController();
var disController= TextEditingController();
var description= TextEditingController();
bool isAvtivated = false;
 
 DateTime _selectedDate = DateTime.now();

  void initState(){
   dateText = TextEditingController();
   title = TextEditingController();
   disController = TextEditingController();
   description= TextEditingController();
    super.initState();
   } 


void _Addcoupon() async {
  if(title.text.isNotEmpty && disController.text.isNotEmpty) {
    try {
      String couponId = FirebaseFirestore.instance.collection('coupons').doc().id;

      // Créez une instance du modèle Coupon avec les données du formulaire
      Coupon couponData = Coupon(
        id: couponId,
        title: title.text,
        discount: double.parse(disController.text),
        expiryDate: dateText.text,
        description: description.text,
        isAvtivated: isAvtivated,
      );

      // Convertissez l'instance du modèle en une Map
      Map<String, dynamic> couponMap = couponData.toMap();

      // Enregistrez les données dans Firestore
      await FirebaseFirestore.instance.collection('coupons').doc(couponId).set(couponMap);

       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Données stockées avec succès.'),
            duration: Duration(seconds: 2),
          ),
        );
   
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
                        'Code promo',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                     SizedBox(height: 50.0),
                     Row(
      children: [
                    
                         
        SizedBox(width: 50.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 250.0,
                                        child: TextField(
                                          controller: title,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(labelText: 'Titre '),
                                        ),
                                      ),
                            ],
                          ),
      ],
      
    ),
     SizedBox(height: 16.0),
Row(
      children: [
                    
                         
        SizedBox(width: 50.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 250.0,
                                        child: TextField(
                                          controller: disController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(labelText: 'Remise '),
                                        ),
                                      ),
                            ],
                          ),
      ],
      
    ),

                      Row(
                        children: [
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: dateText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date est obligatoire';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(),
                                labelText: 'Date d/expiration',
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
                           
                          
                        ],
                      ),
Row(
      children: [
                    
                         
        SizedBox(width: 50.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 250.0,
                                        child: TextField(
                                          controller: description,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(labelText: 'Description '),
                                        ),
                                      ),
                            ],
                          ),
      ],
      
    ),

                   
           
                           SizedBox(height: 16.0),
Row(
      children: [
                    
                         
        SizedBox(width: 50.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
          width: 600,
          child: Row(
            children: [
              Text('Disponibilité: '),
              Switch(
                value: isAvtivated, // Use the local variable here
                onChanged: (value) {
                  setState(() {
                    isAvtivated = value;
                  });
                },
              ),
            ],
          ),
           ),
                            ],
                          ),
      ],
      
    ),


            
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () {
                 _Addcoupon();
                },
                child: Text('Sauvegarder'),
              ),
            ],
          ),
          
        ),
        
      ),   );
  }
}
