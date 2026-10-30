import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view/privacy.dart';
import 'package:rentadmin/view/support.dart';
import 'bank.dart';
import 'change.dart';
import 'login.dart';
import '../view_model/adminprofileviewmodel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "lock":
        return CupertinoIcons.lock;
      case "doc_text":
        return CupertinoIcons.doc_text;
      case "lock_shield":
        return CupertinoIcons.lock_shield;
      default:
        return CupertinoIcons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProfileViewModel>(
      builder: (context, profileVM, child) {
        var profile = profileVM.profileModel;

        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Manage your admin account",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.deepPurple.shade50,
                        child: Icon(
                          CupertinoIcons.person_fill,
                          size: 45,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        profile.email,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        profile.role,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profile.accountTitles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePassword()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HelpSupport()),
                          );
                        } else if (index == 2) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Terms(mdFilename: 'terms.md')));

                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple.shade50,
                            child: Icon(
                              _getIconData(profile.accountIcons[index]),
                              color: Colors.deepPurple,
                            ),
                          ),
                          title: Text(
                            profile.accountTitles[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            CupertinoIcons.right_chevron,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "Admin Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Admin ID",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            profile.adminId,
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
                          Text(
                            "Role",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            profile.role,
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
                          Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            profile.status,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Padding(
                            padding: EdgeInsets.only(left: 36.0),
                            child: Text(
                              "Are you sure you want to logout?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: profileVM.isLoading
                                      ? null
                                      : () {
                                    Navigator.pop(context);
                                    profileVM.handleSignOut(context, () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => AdminLogin()),
                                            (route) => false,
                                      );
                                    });
                                  },
                                  child: Text("Yes"),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: profileVM.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "LOGOUT",
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