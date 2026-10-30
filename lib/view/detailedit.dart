import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/product edit model.dart';
import '../view_model/detail edit view model.dart';

class DetailEditPage extends StatefulWidget {
  final String productId;
  final Map<String, dynamic> productData;

  const DetailEditPage({
    super.key,
    required this.productId,
    required this.productData,
  });

  @override
  State<DetailEditPage> createState() => _DetailEditPageState();
}

class _DetailEditPageState extends State<DetailEditPage> {
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController rentController;
  late TextEditingController securityController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  late TextEditingController feature1Controller;
  late TextEditingController feature2Controller;
  late TextEditingController feature3Controller;
  late TextEditingController feature4Controller;

  @override
  void initState() {
    super.initState();
    var model = DetailEdit.fromMap(widget.productData, widget.productId);
    nameController = TextEditingController(text: model.productName);
    categoryController = TextEditingController(text: model.category);
    rentController = TextEditingController(text: model.rentPrice.toString());
    securityController = TextEditingController(text: model.securityDeposit.toString());
    locationController = TextEditingController(text: model.pickupLocation);
    descriptionController = TextEditingController(text: model.description);

    List<String> f = model.features;
    feature1Controller = TextEditingController(text: f.isNotEmpty ? f[0] : "");
    feature2Controller = TextEditingController(text: f.length > 1 ? f[1] : "");
    feature3Controller = TextEditingController(text: f.length > 2 ? f[2] : "");
    feature4Controller = TextEditingController(text: f.length > 3 ? f[3] : "");
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    rentController.dispose();
    securityController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    feature1Controller.dispose();
    feature2Controller.dispose();
    feature3Controller.dispose();
    feature4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var initialModel = DetailEdit.fromMap(widget.productData, widget.productId);

    return Consumer<DetailEditViewModel>(
      builder: (context, editVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            title: Text(
              "Edit Product",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rent / Day (₹)", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          TextField(
                            controller: rentController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Security Deposit (₹)", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          TextField(
                            controller: securityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text(
                  "Pickup Location",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Feature 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: feature1Controller,
                  decoration: InputDecoration(
                    hintText: "Enter feature 1 (e.g., 24 MP Camera)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Feature 2",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: feature2Controller,
                  decoration: InputDecoration(
                    hintText: "Enter feature 2 (e.g., 4K Video)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Feature 3",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: feature3Controller,
                  decoration: InputDecoration(
                    hintText: "Enter feature 3 (e.g., WiFi Supported)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Feature 4",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: feature4Controller,
                  decoration: InputDecoration(
                    hintText: "Enter feature 4 (e.g., Extra Battery)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: editVM.isSaving
                        ? null
                        : () {
                      List<String> updatedFeatures = [
                        feature1Controller.text.trim(),
                        feature2Controller.text.trim(),
                        feature3Controller.text.trim(),
                        feature4Controller.text.trim(),
                      ].where((text) => text.isNotEmpty).toList();

                      DetailEdit updatedModel = DetailEdit(
                        productId: widget.productId,
                        productName: nameController.text.trim(),
                        category: categoryController.text.trim(),
                        rentPrice: double.tryParse(rentController.text.trim()) ?? 0.0,
                        securityDeposit: double.tryParse(securityController.text.trim()) ?? 0.0,
                        startDate: initialModel.startDate,
                        endDate: initialModel.endDate,
                        pickupLocation: locationController.text.trim(),
                        description: descriptionController.text.trim(),
                        features: updatedFeatures,
                        productImage: initialModel.productImage,
                      );

                      editVM.handleUpdateProduct(
                        context: context,
                        model: updatedModel,
                        onSuccess: () => Navigator.pop(context),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: editVM.isSaving
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "UPDATE PRODUCT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}