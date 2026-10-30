import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'all.dart';

class SellerBookings extends StatefulWidget {
  const SellerBookings({super.key});

  @override
  State<SellerBookings> createState() => _SellerBookingsState();
}

class _SellerBookingsState extends State<SellerBookings> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(15),
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
                        "Bookings",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        "Manage your rental requests",
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
                  Tab(text: "Active"),
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
              ),
              SizedBox(height: 10),
               Expanded(
                child: TabBarView(
                  children: [
                    All(statusFilter: "Active"),
                    All(statusFilter: "Completed"),
                    All(statusFilter: "Cancelled"),
                  ],
                ),
              ),
               SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}