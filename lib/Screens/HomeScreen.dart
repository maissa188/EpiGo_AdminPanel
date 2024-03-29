import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:epigo_adminpanel/services/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:intl/intl.dart';





class HomeScreen extends StatefulWidget {
   static const String id = 'home-screen';
   
 State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
 late Timer _timer;
  String timeText = "";
  String dateText = "";
  String formatCurrentLiveTime(DateTime time){
    return DateFormat("hh:mm:ss a").format(time);
  }
    String formatCurrentDate(DateTime date){
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
  final DateTime timeNow = DateTime.now();
  final String liveTime = formatCurrentLiveTime(timeNow);

  if (this.mounted) {
    setState(() {
      timeText = liveTime;
      print(liveTime);
    });
  }

  print('Updated time: $timeText');
}


@override
void initState() {
  super.initState();

  // Décommentez cette partie pour mettre à jour l'heure en temps réel
 _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
  getCurrentLiveTime();
});


}

 @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Widget build(BuildContext context) {
     FirebaseServices _services = FirebaseServices();
  Widget analyticWidget(String title, String value, IconData iconData , Color containerColor) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
              color: containerColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize:   18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(value),
              ],
            ),
            Icon(
              iconData,
              size: 50, // Adjust the size of the icon as needed
              color: Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}

    SideBarwidget _sideBar = SideBarwidget();
   
   return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
           backgroundColor: greenColor,
        title: const Text('Epi Go Dashboard',style: TextStyle(color:Colors.white,),),
      ),
        sideBar: _sideBar.sideBarMenus(context,HomeScreen.id),
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              // ignore: prefer_const_constructors
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  
      Center(
  child:  Padding(
    padding: EdgeInsets.all(12.0),
    child: Text( 'Welcome to Epi Go Dashboard', style: commonTextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
  ),
Text(timeText, style: const TextStyle(
            fontSize: 20,
            color: Colors.black,)),

                ],
              ),
              
            ),
            
          ),
        Column(
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
                children: [
                  StreamBuilder<QuerySnapshot>(
      stream: _services.users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){

            return  analyticWidget("Total Utilisateur", snapshot.data!.size.toString(), Icons.person,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
    
               StreamBuilder<QuerySnapshot>(
      stream: _services.fournisseurs.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){
            return  analyticWidget("Total Fournisseurs",snapshot.data!.size.toString(),CupertinoIcons.group_solid,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
     StreamBuilder<QuerySnapshot>(
      stream: _services.categories.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){
            return  analyticWidget("Total Categories",snapshot.data!.size.toString(),Icons.category,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
                       StreamBuilder<QuerySnapshot>(
      stream: _services.produits.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color:Color.fromARGB(255, 216, 189, 154)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 216, 189, 154),
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){
            return  analyticWidget("Total Produits",snapshot.data!.size.toString(),Icons.production_quantity_limits,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
             
             StreamBuilder<QuerySnapshot>(
      stream: _services.orders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color:Color.fromARGB(255, 216, 189, 154)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 216, 189, 154),
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){
            return  analyticWidget("Total Commandes",snapshot.data!.size.toString(),Icons.shopping_cart,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
      StreamBuilder<QuerySnapshot>(
      stream: _services.deliveryMethods.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color:Color.fromARGB(255, 216, 189, 154)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 216, 189, 154),
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white),),
                ),
              );
            }
            if(snapshot.hasData){
            return  analyticWidget("Methodes de livraisons",snapshot.data!.size.toString(), Icons.delivery_dining_outlined,Color.fromARGB(255, 216, 189, 154));
            }
            return SizedBox();

      },
    ),
      
                ],
              ),
          ],
        ),
        
         
        ],
      ),
      
    );
  }
}