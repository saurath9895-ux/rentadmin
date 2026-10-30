import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/adminviewmodel.dart';
import 'allusers.dart';
import 'sellers.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<String> collectionNames = ["users", "products", "bookings", "sellers"];
  final List<String> labels = ["Users", "Listings", "Bookings", "Sellers"];
  final List<IconData> icons = [
    CupertinoIcons.person_2,
    CupertinoIcons.cube_box,
    CupertinoIcons.calendar,
    CupertinoIcons.person_badge_plus,
  ];
  final List<Color> cardColors = [
    Colors.blue,
    Colors.deepPurple,
    Colors.orange,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminViewModel>(
      builder: (context, adminVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RentMe",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            Text(
                              "Admin Panel",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Hi, Admin 👋",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.admin_panel_settings,
                              color: Colors.deepPurple,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Admin Dashboard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Manage your RentMe platform",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.3,
                      ),
                      itemBuilder: (context, index) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: adminVM.getCollectionCountStream(collectionNames[index]),
                          builder: (context, snapshot) {
                            String count = "0";
                            if (snapshot.hasData) {
                              count = snapshot.data!.docs.length.toString();
                            }

                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      icons[index],
                                      color: cardColors[index],
                                      size: 25,
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      count,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      labels[index],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 22),
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.6,
                      ),
                      itemBuilder: (context, index) {
                        final List<String> quickNames = [
                          "Users",
                          "Sellers",
                        ];

                        final List<IconData> quickIcons = [
                          CupertinoIcons.person_2,
                          CupertinoIcons.person_badge_plus,
                        ];

                        return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AllUsers()));
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Sellers()
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  quickIcons[index],
                                  color: Colors.deepPurple,
                                  size: 28,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  quickNames[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 22),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}