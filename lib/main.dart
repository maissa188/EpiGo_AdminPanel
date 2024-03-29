// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Screens/Banners/banner.dart';
import 'package:epigo_adminpanel/Screens/Categories/CategoryScreen.dart';
import 'package:epigo_adminpanel/Screens/Coupon/coupons.dart';
import 'package:epigo_adminpanel/Screens/DeliveryMethods/delivery_screen.dart';
import 'package:epigo_adminpanel/Screens/Fournisseurs/fournisseur_Screen.dart';
import 'package:epigo_adminpanel/Screens/Produits/Stock.dart';
import 'package:epigo_adminpanel/Screens/Produits/productscreen.dart';
import 'package:epigo_adminpanel/Screens/Users/userscreen.dart';
import 'package:epigo_adminpanel/Screens/order/OrdersScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';

void main() async {
  

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: const FirebaseOptions(
  apiKey: "AIzaSyDyKFvFMXPfITLCdsMDNXjv_IRea_ArMG4",
 
appId: "1:109178811801:web:d31703503fff6550128f08",
  projectId: "epigo-8f971",
  messagingSenderId: "109178811801",
    storageBucket: "epigo-8f971.appspot.com",
  )

);
FirebaseFirestore.instance.settings =
  const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

runApp(MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //close dialog
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
 
     
      home:  LoginScreen(),
          routes: {
        HomeScreen.id:(context)=> HomeScreen(),
        CategoryScreen.id :(context)=>  CategoryScreen(),
        BannerScreen.id :(context)=>  BannerScreen(), 
        ProductScreen.id :(context)=>  ProductScreen(), 
        UserScreen.id :(context)=>  UserScreen(), 
       Fournisseur_Screen.id:(context)=>Fournisseur_Screen(),
       OrdersScreen.id:(context)=> OrdersScreen(),
         DeliveryMethods.id:(context)=>DeliveryMethods(),
       Stock_Screen .id:(context)=>Stock_Screen(),
         Coupon_Screen.id:(context)=>Coupon_Screen(),
        

      },
     
    );
  }
}