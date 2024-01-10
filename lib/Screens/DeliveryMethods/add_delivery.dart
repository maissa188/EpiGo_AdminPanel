import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Modeles/delivery_methods.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:epigo_adminpanel/Screens/DeliveryMethods/delivery_screen.dart';

import 'dart:html' as html;



class AddDelivery extends StatefulWidget {
    static const String id = 'DeliveryMethods-screen';
  @override
  State<AddDelivery> createState() => _AddDeliveryState();
}

class _AddDeliveryState extends State<AddDelivery> {
    TextEditingController nameController = TextEditingController();
    TextEditingController daysController = TextEditingController();
    bool _isButtonVisible = true;
   bool _visible = false;
  String imgUrl = '';
  html.File? file;
   @override
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 void initState(){
    nameController = TextEditingController();
    daysController = TextEditingController();

    super.initState();
   } 

  Future<void> selectImage() async {
  FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
  input.click();
  input.onChange.listen((event) async {
    print("File selected");
    final file = input.files?.first;
  final reader = FileReader();
  reader.readAsDataUrl(file!);
  reader.onLoadEnd.listen((event) async {
  print("File loaded");
  if (file != null) {
    setState(() {
      _visible = true;
      imgUrl = reader.result as String;
      this.file = file ;
      _isButtonVisible = false;
    });
  }
});
  });
 }
  
Future<void> uploadToFirebase() async {
  if (_visible && file != null && nameController.text.isNotEmpty) {
    try {
      FirebaseStorage fs = FirebaseStorage.instance;
      int date = DateTime.now().millisecondsSinceEpoch;
      var snapshot = await fs.ref().child('delvry/$date').putBlob(file!);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await addDataToFirestore(downloadUrl, nameController.text,daysController.text);
      setState(() {
        imgUrl = downloadUrl;
      });
    } catch (error) {
    }
  }
}

Future<void> addDataToFirestore(String imgUrl, String name,String days) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 String id = FirebaseFirestore.instance.collection('deliveryMethods').doc().id;
  DeliveryMethod deliveryMethod = DeliveryMethod(
    id : id,
    imgUrl: imgUrl,
     name: name,
     days: days);
     await firestore.collection('deliveryMethods').doc(id).set(deliveryMethod.toMap());
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
      sideBar: _sideBar.sideBarMenus(context,DeliveryMethods.id),
        body: SafeArea(
            child: SingleChildScrollView(
               padding: EdgeInsets.all(44),
          child: Form(
          key: _formKey,
            child: Column(
              children: [
                const Text('Ajouter une méthode de livraison',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            
              SizedBox(height: 30,), 
  Container(
  height: 250,
  width: 250,
  decoration: BoxDecoration(
    border: Border.all(),
    color: Colors.grey.shade50,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (_isButtonVisible)
        TextButton(
          onPressed: () {
            selectImage();
          },
          child: const Text(
            'Ajouter Image',
            style: TextStyle(color: Colors.black),
          ),
        ),
      //SizedBox(height: 10),
      imgUrl.isNotEmpty
          ? Image.network(
              imgUrl,
              fit: BoxFit.cover,
            )
          : Container(),
    ],
  ),
),


          
      SizedBox(
  width: 250,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        controller: nameController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          labelText: 'Nom',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Le nom est obligatoire';
          }
          return null;
        },
      ),
      if (_formKey.currentState?.validate() ?? false)
        const Text(
          'Le nom est obligatoire',
          style: TextStyle(color: Colors.red),
        ),
    ],
  ),
),



  SizedBox(height:10.0),       
      SizedBox(
  width: 250,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        controller: daysController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          labelText: 'Durée',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Durée est obligatoire';
          }
          return null;
        },
      ),
      if (_formKey.currentState?.validate() ?? false)
        const Text(
          'Durée est obligatoire',
          style: TextStyle(color: Colors.red),
        ),
    ],
  ),
),

                         
                   SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 400),
                        child: Row(
                          children: [
                             Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
     
                          
           TextButton(
           child: Text('Sauvegarder',style: TextStyle(color: Colors.black)),
           onPressed: () {
             if (_visible) {
               if (file != null) {
                 if (_formKey.currentState?.validate() ?? false) {
            uploadToFirebase();
             Navigator.pushReplacement(
             context,
             MaterialPageRoute(builder: (context) => DeliveryMethods()),
           );
            ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Méthode de livraison ajoutée avec Succées!'),
    backgroundColor: Colors.green,
  ),

);
            
                 } 
                 else {
           
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez sélectionner une image et remplir les champs'),
                backgroundColor: Colors.red,
              ),
            );
                 }
               } 
             } else {
               // Show SnackBar if the image is not visible
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
            content: Text('Veuillez sélectionner une image'),
            backgroundColor: Colors.red,
                 ),
               );
             }
           },
           style: TextButton.styleFrom(
             backgroundColor: primaryColor
           ),
         ),
                                           TextButton(
      onPressed: () {
        // Navigate to CategoryScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>DeliveryMethods()),
        );
      },
      child: const Text(
        'Annuler',
        style: TextStyle(color: Colors.black),
      ),
    ),
         
                                  ],
                                ),
                              ),
              ])
          
                      )
                    )
            ]),
          )
            )
        )
    );
  }
}