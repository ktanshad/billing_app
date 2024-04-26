
import 'package:billing_app/controller/auth_provider.dart';
import 'package:billing_app/view/login_page/loginpage..dart';
import 'package:billing_app/view/register_page.dart/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    if (authprovider.showLoginPage) {
      return LoginPage(onTap: authprovider.togglepages);
    } else {
      return RegisterPage(onTap: authprovider.togglepages);
      
    }
  }
}
