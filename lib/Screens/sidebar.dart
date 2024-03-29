import 'package:epigo_adminpanel/Screens/Banners/banner.dart';
import 'package:epigo_adminpanel/Screens/Categories/CategoryScreen.dart';
import 'package:epigo_adminpanel/Screens/Coupon/coupons.dart';
import 'package:epigo_adminpanel/Screens/DeliveryMethods/delivery_screen.dart';
import 'package:epigo_adminpanel/Screens/Fournisseurs/fournisseur_Screen.dart';
import 'package:epigo_adminpanel/Screens/HomeScreen.dart';
import 'package:epigo_adminpanel/Screens/Produits/Stock.dart';
import 'package:epigo_adminpanel/Screens/Produits/productscreen.dart';
import 'package:epigo_adminpanel/Screens/Users/userscreen.dart';
import 'package:epigo_adminpanel/Screens/order/OrdersScreen.dart';
import 'package:epigo_adminpanel/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
  class SideBarwidget {
    sideBarMenus(context, selectedRoute){
    return SideBar(
      backgroundColor:Colors.white12,
      activeBackgroundColor: const Color.fromARGB(255, 216, 189, 154),
      activeIconColor: Colors.white,
      activeTextStyle: const TextStyle(color:Colors.white),
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: HomeScreen.id,
            icon: Icons.dashboard,
          ),
             AdminMenuItem(
            title: 'Produits',
            route: ProductScreen.id,
            icon: Icons.production_quantity_limits,
          ),
          AdminMenuItem(title: 'Parametrage',
          icon: Icons.settings,
          children: [
              AdminMenuItem(
            title: 'Methodes de livraisons',
            route:   DeliveryMethods.id,
            icon: Icons.delivery_dining_outlined,
          ),
           AdminMenuItem(
            title: 'Categorie',
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
           ]
           ),
              AdminMenuItem(
            title: 'Fournisseurs',
            route: Fournisseur_Screen.id,
            icon: CupertinoIcons.group_solid,
          ),
           AdminMenuItem(
            title: 'Utilisateurs',
            route: UserScreen.id,
            icon: Icons.supervised_user_circle_sharp,
          ),
             AdminMenuItem(
          title: 'Commandes',
          route: OrdersScreen.id, // Replace with the actual route for Orders
          icon: Icons.shopping_cart, // Replace with the desired icon for Orders
        ),
   AdminMenuItem(
          title: 'Stock',
          route:Stock_Screen.id, // Replace with the actual route for Orders
          icon: Icons.check_box, 
        ),
         AdminMenuItem(
          title: 'Code promo',
          route: Coupon_Screen .id, // Replace with the actual route for Orders
          icon: Icons.discount, 
        ),
        ], 
        
        selectedRoute: selectedRoute,
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white12,
          child: const Center(
             child: Text(
              'Menu',
              style: TextStyle(
                color: Color(0xFF8B4513),fontStyle:FontStyle.normal,fontSize: 25,
               fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    footer: Container(
          height: 170,
          width: double.infinity,
          color:Colors.white12,
          child: Center(
            child: Image.asset("images/logo.png",),
          ),
        ),
      );
  }

  }