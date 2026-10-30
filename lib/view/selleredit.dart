import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view_model/seller%20details%20view%20model.dart';
import '../model/seller model.dart';

class SellerDetails extends StatefulWidget {
  final String sellerId;

  const SellerDetails({super.key, required this.sellerId});

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(SellerDetailsModel model) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.deepPurple.shade50,
          backgroundImage: model.profileImage != null && model.profileImage!.isNotEmpty
              ? NetworkImage(model.profileImage!)
              : null,
          child: model.profileImage == null || model.profileImage!.isEmpty
              ? Icon(CupertinoIcons.person, size: 45, color: Colors.deepPurple)
              : null,
        ),
        SizedBox(height: 10),
        Text(
          model.name,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3),
        Text(
          model.email,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsSection(SellerDetailsModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text("Name", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text(model.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 10),
          Text("Email", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text(model.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 10),
          Text("Phone", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text(model.phone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 10),
          Text("Location", style: TextStyle(color: Colors.grey, fontSize: 12)),
          Text(model.address, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildImageCardSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String? imageUrl,
    required String emptyMessage,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 15),
          imageUrl != null && imageUrl.isNotEmpty
              ? GestureDetector(
            onTap: () => _showFullImage(context, imageUrl),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Chip(
                      backgroundColor: Colors.black54,
                      label: Text("Tap to view full", style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ),
                ),
              ),
            ),
          )
              : Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                emptyMessage,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, SellerDetailsViewModel sellerVM) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: sellerVM.isUpdating
                ? null
                : () => sellerVM.handleAcceptSeller(
              context: context,
              sellerId: widget.sellerId,
              onSuccess: () => Navigator.pop(context),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: sellerVM.isUpdating
                ? CircularProgressIndicator(color: Colors.white)
                : Text("ACCEPT SELLER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: sellerVM.isUpdating
                ? null
                : () => sellerVM.handleRejectSeller(
              context: context,
              sellerId: widget.sellerId,
              onSuccess: () => Navigator.pop(context),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: sellerVM.isUpdating
                ? CircularProgressIndicator(color: Colors.white)
                : Text("REJECT SELLER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SellerDetailsViewModel>(
      builder: (context, sellerVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.back, color: Colors.black),
            ),
            title: Text(
              "Seller Details",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection("sellers").doc(widget.sellerId).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(
                  child: Text(
                    "Seller not found",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                );
              }

              var rawData = snapshot.data!.data() as Map<String, dynamic>? ?? {};
              SellerDetailsModel model = SellerDetailsModel.fromMap(rawData, widget.sellerId);

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      _buildHeaderSection(model),
                      SizedBox(height: 25),
                      _buildPersonalDetailsSection(model),
                      SizedBox(height: 20),
                      _buildImageCardSection(
                        context: context,
                        title: "Government ID",
                        subtitle: model.verificationType,
                        imageUrl: model.govIdUrl,
                        emptyMessage: "No Government ID uploaded yet.",
                      ),
                      SizedBox(height: 20),
                      _buildImageCardSection(
                        context: context,
                        title: "Store Proof Image",
                        subtitle: "Storefront / License",
                        imageUrl: model.storeProofUrl,
                        emptyMessage: "No Store Proof uploaded yet.",
                      ),
                      SizedBox(height: 25),
                      _buildActionButtons(context, sellerVM),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}