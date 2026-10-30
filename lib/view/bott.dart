import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentadmin/view/book.dart';
import 'package:rentadmin/view/home.dart';
import 'package:rentadmin/view/listings.dart';
import 'package:rentadmin/view/profile.dart';
import 'package:rentadmin/view/revenue.dart';
import 'package:rentadmin/view/sellers.dart';
import 'package:rentadmin/view/selleredit.dart';

import 'allprod.dart';


class Bott extends StatefulWidget {
  const Bott({super.key});

  @override
  State<Bott> createState() => _BottState();
}


class _BottState extends State<Bott> {
  int select = 0;

  List page = [
AdminHome(),
    SellerBookings(),
    Allprod(),
    Revenue(),
    Profile()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: select,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,

        onTap: (index) {
          setState(() {
            select = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: "Bookings",
            icon: Icon(CupertinoIcons.doc_on_clipboard_fill),
            activeIcon: Icon(CupertinoIcons.cube_box_fill),
          ),
          BottomNavigationBarItem(
            label: "Listings",
            icon: Icon(CupertinoIcons.cube_box),
            activeIcon: Icon(CupertinoIcons.cube_box_fill),
          ),
          BottomNavigationBarItem(
            label: "Revenue",
            icon: Icon(Icons.monetization_on_outlined),
            activeIcon: Icon(Icons.monetization_on_outlined),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(CupertinoIcons.profile_circled),
            activeIcon: Icon(CupertinoIcons.person_crop_circle_fill),
          ),
        ],
      ),
      body: page[select],
    );
  }
}