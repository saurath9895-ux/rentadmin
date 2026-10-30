import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/product view model.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic>? productData;
  final String? productId;

  const Detail({super.key, this.productData, this.productId});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final List<String> features = [
    "24 MP Camera",
    "4K Video",
    "WiFi Supported",
    "Extra Battery",
  ];

  final List<IconData> featureicons = [
    CupertinoIcons.camera,
    CupertinoIcons.video_camera,
    CupertinoIcons.wifi,
    CupertinoIcons.battery_100,
  ];

  @override
  Widget build(BuildContext context) {
    var data = widget.productData ?? {};
    String productName = data["product"] ?? data["name"] ?? "Sony Camera";
    String rentPrice = data["rent"]?.toString() ?? data["price"]?.toString() ?? "500";
    String securityDeposit = data["security"]?.toString() ?? "2000";
    String description = data["description"] ?? "Sony Camera is available for rent for photography, events and personal use. The camera is well maintained and comes with battery and charger.";
    String sellerId = data["sellerId"] ?? "";

    String? productImage = data["image"] ?? data["productImage"];

    return Consumer<ProductViewModel>(
      builder: (context, productVM, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 330,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Colors.grey.shade200,
                    image: productImage != null && productImage.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(productImage),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: productImage == null || productImage.isEmpty
                      ? Center(
                    child: Icon(CupertinoIcons.cube_box, size: 60, color: Colors.deepPurple),
                  )
                      : Padding(
                    padding: EdgeInsets.only(bottom: 170.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(CupertinoIcons.back, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(CupertinoIcons.heart, color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productName,
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(CupertinoIcons.share, color: Colors.deepPurple),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 5),
                          Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text("(24 reviews)", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(CupertinoIcons.location_solid, color: Colors.deepPurple, size: 18),
                          SizedBox(width: 5),
                          Text("Kochi, Kerala", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹$rentPrice",
                                  style: TextStyle(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text("Per Day", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Container(height: 50, width: 1, color: Colors.grey),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹$securityDeposit",
                                  style: TextStyle(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text("Security Deposit", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text("Features", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 140,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: features.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(featureicons[index], color: Colors.deepPurple),
                                  SizedBox(width: 8),
                                  Text(features[index], style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 22),
                      Text("Seller Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      FutureBuilder<Map<String, dynamic>?>(
                        future: productVM.fetchSellerDetails(sellerId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(child: CircularProgressIndicator(color: Colors.deepPurple)),
                            );
                          }

                          var seller = snapshot.data;
                          String sellerName = seller?["shopName"] ?? seller?["name"] ?? "Rahul Sharma";
                          String sellerPhone = seller?["phone"] ?? seller?["contactPhone"] ?? "+91 98765 43210";
                          String sellerEmail = seller?["email"] ?? seller?["supportEmail"] ?? "rahul@gmail.com";
                          String sellerLocation = seller?["address"] ?? seller?["location"] ?? "Kochi, Kerala, India";
                          String? sellerProfileImage = seller?["profileImage"] ?? seller?["image"];

                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.deepPurple.shade100),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Colors.white,
                                      backgroundImage: sellerProfileImage != null && sellerProfileImage.isNotEmpty
                                          ? NetworkImage(sellerProfileImage)
                                          : null,
                                      child: sellerProfileImage == null || sellerProfileImage.isEmpty
                                          ? Icon(CupertinoIcons.person_fill, color: Colors.deepPurple, size: 30)
                                          : null,
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sellerName,
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.checkmark_seal_fill, color: Colors.green, size: 16),
                                            SizedBox(width: 5),
                                            Text("Verified Seller", style: TextStyle(color: Colors.green, fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Divider(),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.phone, color: Colors.deepPurple, size: 20),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Phone Number", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                        SizedBox(height: 4),
                                        Text(sellerPhone, style: TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.mail, color: Colors.deepPurple, size: 20),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Email Address", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          SizedBox(height: 4),
                                          Text(sellerEmail, style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(CupertinoIcons.location_solid, color: Colors.deepPurple, size: 20),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Seller Address", style: TextStyle(color: Colors.grey, fontSize: 12)),
                                          SizedBox(height: 4),
                                          Text(sellerLocation, style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 22),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}