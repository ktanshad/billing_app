import 'package:billing_app/constants/contants.dart';
import 'package:billing_app/controller/auth_provider.dart';
import 'package:billing_app/helpers/colors.dart';
import 'package:billing_app/widgets/mybutton_widget.dart';
import 'package:billing_app/widgets/mytextfiled_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: backgroundcolor,
      body: Form(
        key: formkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                kHeigt25,
                  //email textfield
                  MyTextField(
                    controller: authprovider.LoginEmailTextController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Invalid email';
                      }
                    },
                  ),

                kHeigt25,
                  //password textfield
                  MyTextField(
                    controller: authprovider.LoginPassWordTextController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter password';
                      }
                    },
                  ),

                      kHeigt25,
                  //sign in button
                  MyButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          try {
                            await authProvider.signInWithEmailandPassword(
                                authProvider.LoginEmailTextController.text,
                                authProvider.LoginPassWordTextController.text);
                            authProvider.LoginEmailTextController.clear();
                            authProvider.LoginPassWordTextController.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Email and Password don't match",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      text: 'Sign In'),
                
                      kHeigt25,
                  //or continue with
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      Text('Or continue with',style: TextStyle(color: kbuttonColor),),
                      kHeigt25,
                     
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),

                  //google button
                  GestureDetector(
                    onTap: (){
                      authprovider.signInWithGoogle();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/google_icon.jpg',height: 72,)),
                  ),
                
                   kHeigt25,
                  // go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                          onTap: onTap,
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kbuttonColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
