import 'package:billing_app/controller/auth_provider.dart';
import 'package:billing_app/controller/bill_amount_provider.dart';
import 'package:billing_app/controller/customer_provider.dart';
import 'package:billing_app/controller/product_provider.dart';
import 'package:billing_app/firebase_options.dart';
import 'package:billing_app/view/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
          ChangeNotifierProvider(
          create: (context) => CustomerProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => BillAmountProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthGate(),
      ),
    );
  }
}