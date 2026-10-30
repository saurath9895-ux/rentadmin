import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/transcation_model.dart';
import '../view_model/sales view model.dart';

class TransactionDetails extends StatefulWidget {
  final String? transactionId;
  final Map<String, dynamic>? transactionData;

  const TransactionDetails({super.key, this.transactionId, this.transactionData});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  Widget _buildStatusHeader(TransactionDetailsModel model) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: Colors.green,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            "₹${model.totalPaid}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Total Paid by Customer",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            model.status,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionInfoSection(TransactionDetailsModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction Information",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transaction ID"),
                  Text(model.txnId, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Customer"),
                  Text(model.customerName, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product"),
                  Text(model.productName, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Date"),
                  Text(model.startDate, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRentalDetailsSection(TransactionDetailsModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rental Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Start Date"),
                  Text(model.startDate, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("End Date"),
                  Text(model.endDate, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rental Amount"),
                  Text("₹${model.rentAmount}", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Security Deposit"),
                  Text("₹${model.securityDeposit}", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentBreakdownSection(TransactionDetailsModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Breakdown",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Paid"),
                  Text(
                    "₹${model.totalPaid}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("RentMe Commission (10%)"),
                  Text(
                    "₹${model.commission.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Seller Receives"),
                  Text(
                    "₹${model.sellerReceives.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deposit to be Refunded"),
                  Text(
                    "₹${model.securityDeposit}",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionDetailsModel model = TransactionDetailsModel.fromMap(
      widget.transactionData,
      widget.transactionId,
    );

    return Consumer<SalesViewModel>(
      builder: (context, salesVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            backgroundColor: Color(0xffF7F5FF),
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.back, color: Colors.black),
            ),
            title: Text(
              "Transaction Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusHeader(model),
                  SizedBox(height: 20),
                  _buildTransactionInfoSection(model),
                  SizedBox(height: 20),
                  _buildRentalDetailsSection(model),
                  SizedBox(height: 20),
                  _buildPaymentBreakdownSection(model),
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