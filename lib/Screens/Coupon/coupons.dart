// ignore_for_file: camel_case_types, file_names, sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Screens/Coupon/Addcoupon.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../services/Couponsview.dart';
import '../../services/firebase.dart';
import '../../widgets/CouponTable.dart';
class Coupon_Screen extends StatefulWidget {
    static const String id = 'coupon-screen';
  const Coupon_Screen({super.key});

  @override
  State<Coupon_Screen> createState() => _Coupon_ScreenState();
}

class _Coupon_ScreenState extends State<Coupon_Screen> {
  @override
  Widget build(BuildContext context) {
    CouponView myViewModel = CouponView();
    SideBarwidget _sideBar = SideBarwidget();
     final FirebaseServices _services = FirebaseServices();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: greenColor,
        title: const Text(
          'Epi Go Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      sideBar: _sideBar.sideBarMenus(context, Coupon_Screen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Coupons',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Addcoupon_Screen(),
                      ),
                    );
                  },
                  child: Text(
                    'Ajouter code promo',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                ),
              ),
              SizedBox(height:10.0),
             // const Divider( thickness: 5, ),
    StreamBuilder<QuerySnapshot>(
                stream: _services.coupons.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> documentList =
                      snapshot.data!.docs.toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documentList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = documentList[index];
                      return CouponCard(document: document);
                    },
                  );
                },
              ),

             // Divider(thickness: 5, ),
            ],
          ),
        ),
      ),
    );
  }
}
