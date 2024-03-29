import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7043);
Color beigeColor = Color.fromARGB(255, 216, 189, 154);
Color greenColor = Color.fromARGB(255, 108, 161, 108);
Color brownColor = Color.fromARGB(255, 165, 42, 42);
Color chocolateColor = Color(0xFFD2691E);
Color darkBrownColor = Color(0xFF8B4513);
Color lightGray = const Color(0xFFA4A6B3);
Color dark = const Color(0xFF363740);
Color active = Color.fromARGB(255, 69, 89, 198);
Color primaryColor= const Color(0xffd1ad17);


TextStyle commonTextStyle({
  double fontSize = 16,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

const kontColor = Color(0xFF5C6BC0);
const kPrimaryLightColor = Color(0xFFF5F5F5);
//const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
Color light =  const Color(0xFFFF7043);
  
const double defaultPadding = 20.0;
final Future<FirebaseApp> initialization = Firebase.initializeApp();

FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;