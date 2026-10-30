import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view/all.dart';
import 'package:rentadmin/view/sellerallview.dart';
import 'package:rentadmin/view_model/sellerlistviewmodel.dart';


class Sellers extends StatefulWidget {
  const Sellers({super.key});

  @override
  State<Sellers> createState() => _SellersState();
}

class _SellersState extends State<Sellers> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SellerListViewModel>(
      builder: (context, sellerListVM, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Color(0xffF7F5FF),
            body: Padding(
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
                            "Sellers",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Manage registered sellers",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TabBar(
                    labelColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.deepPurple,
                    tabs: [
                      Tab(text: "Active"),
                      Tab(text: "Pending"),
                      Tab(text: "Rejected"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SellerAllView(statusFilter: "Active"),
                        SellerAllView(statusFilter: "Pending"),
                        SellerAllView(statusFilter: "Rejected"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}