import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Screens/Coupon/coupons.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:epigo_adminpanel/Screens/Coupon/coupons.dart';
import '../../Modeles/coupon.dart';
import '../../constants.dart';

class Addcoupon_Screen extends StatefulWidget {
   
  const Addcoupon_Screen({super.key});

  @override
  State<Addcoupon_Screen> createState() => _Addcoupon_ScreenState();
}

class _Addcoupon_ScreenState extends State<Addcoupon_Screen> {
DateTime selectedDate = DateTime.now();
   
var dateText = TextEditingController();
var datedebit = TextEditingController();
var title = TextEditingController();
var disController= TextEditingController();
var description= TextEditingController();
bool isActivated = false;

 
 DateTime _selectedDate = DateTime.now();

  void initState(){
   dateText = TextEditingController();
   datedebit = TextEditingController();
   title = TextEditingController();
   disController = TextEditingController();
   description= TextEditingController();
    super.initState();
   } 


void _Addcoupon() async {
  if(title.text.isNotEmpty && disController.text.isNotEmpty && description.text.isNotEmpty && dateText.text.isNotEmpty ) {
    try {
      String couponId = FirebaseFirestore.instance.collection('coupons').doc().id;

      // Créez une instance du modèle Coupon avec les données du formulaire
      CouponModel couponData = CouponModel(
        id: couponId,
        title: title.text,
        discount: int.parse(disController.text),
        expiryDate: dateText.text,
        debitDate:datedebit.text,
        description: description.text,
       isActivated: isActivated,
      );

      // Convertissez l'instance du modèle en une Map
    Map<String, dynamic> couponMap = couponData.toMap();

      // Enregistrez les données dans Firestore
      await FirebaseFirestore.instance.collection('coupons').doc(couponId).set(couponMap);

       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Données stockées avec succès.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      // Rediriger vers la page Coupons_Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Coupon_Screen()),
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
         backgroundColor: Colors.red,
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
_selecttDate(context)async{
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
      datedebit.text =formattedText;
    });
     }
}


  @override
  Widget build(BuildContext context) {
   SideBarwidget _sideBar = SideBarwidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
           backgroundColor: greenColor,
        title: const Text('Epi Go Dashboard',style: TextStyle(color:Colors.white,),),
      ),
      sideBar: _sideBar.sideBarMenus(context,Coupon_Screen.id),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
             Align(
  alignment: Alignment.topLeft,
  child: const Text(
    'Coupon de réduction',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
),
   SizedBox(height: 50.0),
                     Row(
      children: [
                   Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 300.0,
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
     SizedBox(height: 20.0),
Row(
      children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 300.0,
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
     SizedBox(height: 20.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: datedebit,
                              readOnly: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date est obligatoire';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Date débit',
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _selecttDate(context);
                                  },
                                  child: Icon(Icons.date_range_outlined),
                                ),
                              ),
                            ),
                          ),
                           
                          
                        ],
                      ),
              
 SizedBox(height: 20.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: dateText,
                              readOnly: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Date est obligatoire';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Date d\'expiration',
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
                       SizedBox(height: 20.0),
Row(
      children: [
                          Column(
            
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
                                        width: 300.0,
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
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 130.0)),
                              Container(
          width: 600,
          child: Row(
            children: [
              Text('Disponibilité: '),
              Switch(
                value:isActivated, // Use the local variable here
                onChanged: (value) {
                  setState(() {
                    isActivated = value;
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
                  child: Text('Sauvegarder',style: TextStyle(color: Colors.black),),
                   style: ElevatedButton.styleFrom(primary: primaryColor),
                ),
                
            
            ],
          ),
          
        ),
        
      ),   );
  }
}
