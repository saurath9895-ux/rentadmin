import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view/allprod.dart';
import 'package:rentadmin/view_model/product%20view%20model.dart';


class Listings extends StatefulWidget {
  const Listings({super.key});

  @override
  State<Listings> createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, productVM, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF7F5FF),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: DefaultTabController(
              length: 4,
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
                            "My Products",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            "Manage your listed rental items",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                   TabBar(
                    labelColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.deepPurple,
                    tabs: [
                      Tab(text: "All"),
                      Tab(text: "Active"),
                      Tab(text: "Pending"),
                      Tab(text: "Rejected"),
                    ],
                  ),
                  SizedBox(height: 10),
                   Expanded(
                    child: TabBarView(
                      children: [
                        Allprod(statusFilter: "All"),
                        Allprod(statusFilter: "Active"),
                        Allprod(statusFilter: "Pending"),
                        Allprod(statusFilter: "Rejected"),
                      ],
                    ),
                  ), SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}