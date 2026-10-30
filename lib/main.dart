import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view_model/admin%20login%20viewmodel.dart';
import 'package:rentadmin/view_model/adminprofileviewmodel.dart';
import 'package:rentadmin/view_model/adminviewmodel.dart';
import 'package:rentadmin/view_model/bank%20wallet%20viewmodel.dart';
import 'package:rentadmin/view_model/bookingviewmodal.dart';
import 'package:rentadmin/view_model/change%20authviewmodel.dart';
import 'package:rentadmin/view_model/detail%20edit%20view%20model.dart';
import 'package:rentadmin/view_model/product%20view%20model.dart';
import 'package:rentadmin/view_model/revenue%20view%20model.dart';
import 'package:rentadmin/view_model/sales%20view%20model.dart';
import 'package:rentadmin/view_model/seller%20details%20view%20model.dart';
import 'package:rentadmin/view_model/sellerlistviewmodel.dart';
import 'package:rentadmin/view_model/user%20details%20view%20model.dart';
import 'package:rentadmin/view_model/signup.dart';
import 'package:rentadmin/view_model/user%20view%20model.dart';
import 'package:rentadmin/view/spla.dart';
import 'package:rentadmin/supabase/supabse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (SupabaseConfig.url.isNotEmpty && SupabaseConfig.anonKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
    } catch (_) {}
  }

  runApp(const Proclass());
}

class Proclass extends StatelessWidget {
  const Proclass({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => AdminLoginViewModel()),
        ChangeNotifierProvider(create: (context) => AdminProfileViewModel()),
        ChangeNotifierProvider(create: (context) => AdminViewModel()),
        ChangeNotifierProvider(create: (context) => WalletViewModel()),
        ChangeNotifierProvider(create: (context) => BookingViewModel()),
        ChangeNotifierProvider(create: (context) => DetailEditViewModel()),
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => RevenueViewModel()),
        ChangeNotifierProvider(create: (context) => SalesViewModel()),
        ChangeNotifierProvider(create: (context) => SellerDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => SellerListViewModel()),
        ChangeNotifierProvider(create: (context) => SignupViewModel()),
        ChangeNotifierProvider(create: (context) => UserDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => UsersViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Spla(),
      ),
    );
  }
}