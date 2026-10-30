import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/bank wallet viewmodel.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  final TextEditingController holder = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController account = TextEditingController();
  final TextEditingController confirmaccount = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final TextEditingController branch = TextEditingController();

  String accounttype = "Savings";

  @override
  void dispose() {
    holder.dispose();
    bank.dispose();
    account.dispose();
    confirmaccount.dispose();
    ifsc.dispose();
    branch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(
      builder: (context, walletVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            title: Text(
              "Bank Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Bank Details",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Enter your bank account details",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Account Holder Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: holder,
                    decoration: InputDecoration(
                      hintText: "Enter account holder name",
                      prefixIcon: Icon(
                        CupertinoIcons.person,
                      ),
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
                    "Bank Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: bank,
                    decoration: InputDecoration(
                      hintText: "Enter bank name",
                      prefixIcon: Icon(
                        CupertinoIcons.building_2_fill,
                      ),
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
                    "Account Number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: account,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter account number",
                      prefixIcon: Icon(
                        CupertinoIcons.creditcard,
                      ),
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
                    "Confirm Account Number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: confirmaccount,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Re-enter account number",
                      prefixIcon: Icon(
                        CupertinoIcons.creditcard_fill,
                      ),
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
                    "IFSC Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: ifsc,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: "Enter IFSC code",
                      prefixIcon: Icon(
                        CupertinoIcons.number,
                      ),
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
                    "Branch Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: branch,
                    decoration: InputDecoration(
                      hintText: "Enter branch name",
                      prefixIcon: Icon(
                        CupertinoIcons.location,
                      ),
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
                    "Account Type",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: accounttype,
                        items: [
                          DropdownMenuItem(
                            value: "Savings",
                            child: Text("Savings"),
                          ),
                          DropdownMenuItem(
                            value: "Current",
                            child: Text("Current"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            accounttype = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: walletVM.isProcessing
                          ? null
                          : () {
                        walletVM.handleSaveBankDetails(
                          context: context,
                          holder: holder.text,
                          bank: bank.text,
                          accountNumber: account.text,
                          confirmAccountNumber: confirmaccount.text,
                          ifsc: ifsc.text,
                          branch: branch.text,
                          accountType: accounttype,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: walletVM.isProcessing
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        "SAVE BANK DETAILS",
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
          ),
        );
      },
    );
  }
}