import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/user detail model.dart';
import '../view_model/user details view model.dart';

class UserDetails extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  const UserDetails({super.key, required this.userId, required this.userData});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Widget _buildHeaderSection(UserDetailsModel model) {
    bool hasProfileImage = model.profileImage != null &&
        model.profileImage!.isNotEmpty &&
        model.profileImage!.startsWith("http");

    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.deepPurple.shade50,
          backgroundImage: hasProfileImage ? NetworkImage(model.profileImage!) : null,
          child: !hasProfileImage
              ? Icon(
            CupertinoIcons.person,
            size: 45,
            color: Colors.deepPurple,
          )
              : null,
        ),
        SizedBox(height: 12),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          model.email,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsSection(UserDetailsModel model) {
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 18),
          Text("Name", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          Text(model.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text("Email", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          Text(model.email, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text("Phone", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          Text(model.phone, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text("Address", style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          Text(model.address, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(UserDetailsModel model) {
    bool hasDocument = model.idProofUrl != null &&
        model.idProofUrl!.isNotEmpty &&
        model.idProofUrl!.startsWith("http");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Documents",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Container(
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
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purple.shade50,
                    child: Icon(
                      CupertinoIcons.doc_text,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID Proof",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        hasDocument ? "Uploaded" : "Not Provided",
                        style: TextStyle(
                          color: hasDocument ? Colors.green : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  image: hasDocument
                      ? DecorationImage(
                    image: NetworkImage(model.idProofUrl!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: !hasDocument
                    ? Center(
                  child: Text(
                    "No ID Proof Document Uploaded",
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModel model = UserDetailsModel.fromMap(widget.userData, widget.userId);

    return Consumer<UserDetailsViewModel>(
      builder: (context, userDetailsVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
            ),
            title: Text(
              "User Details",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildHeaderSection(model),
                  SizedBox(height: 25),
                  _buildPersonalDetailsSection(model),
                  SizedBox(height: 20),
                  _buildDocumentsSection(model),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}