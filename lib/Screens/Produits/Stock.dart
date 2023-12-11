// ignore_for_file: camel_case_types, file_names, sort_child_properties_last, prefer_const_constructors

import 'package:epigo_adminpanel/Screens/Produits/StockScreen%20.dart';
import 'package:epigo_adminpanel/Screens/sidebar.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:epigo_adminpanel/services/stock_view.dart';
import 'package:epigo_adminpanel/widgets/fournisseur_datatable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class Stock_Screen extends StatefulWidget {
    static const String id = 'stock-screen';
  const Stock_Screen({super.key});

  @override
  State<Stock_Screen> createState() => _Stock_ScreenState();
}

class _Stock_ScreenState extends State<Stock_Screen> {
  @override
  Widget build(BuildContext context) {
    StockView myViewModel = StockView();
        SideBarwidget _sideBar = SideBarwidget();
    return AdminScaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 216, 189, 154),
            title: const Text('Epi Go Dashboard',style: TextStyle(color:Colors.white,),),
           
        ),
       
          
            sideBar: _sideBar.sideBarMenus(context,Stock_Screen.id),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Stocks',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: 30,), 
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(onPressed: () {
              
                              Navigator.push(
  
                                context,
  
                                MaterialPageRoute(
  
                                  builder: (context) =>
  
                                    StockScreen(),
  
                                ),
  
                              );
  
                               
                                }, 
            child: Text('Alimenter le stock',style: TextStyle(color: Colors.black),),
             style: ElevatedButton.styleFrom(primary:primaryColor),
            
            ),
          ), 
                           
         const Divider(thickness: 5,),
        
FournisseurDataTable(viewModel: myViewModel),
          Divider(thickness: 5,),

           
        ],
              )
            )
          )
         );
  }
}