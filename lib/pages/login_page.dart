// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously

import 'package:docpad/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>(); // FormKey to validate the form

  // This function will handle moving to the home page after validation
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Validate the form
      setState(() {
        changeButton = true; // Change the button state to show progress
      });

      await Future.delayed(
          Duration(seconds: 2)); // Simulate network delay or loading
      Navigator.pushNamed(context,
          MyRoutes.homeRoute); // Navigate to the next page if form is valid

      setState(() {
        changeButton = false; // Reset the button state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey, // Attach the form key
          child: Column(
            children: [
              Image.asset(
                "assets/images/login_image.png",
                height: 350,
                width: 350,
              ),
              Text(
                "Welcome to $name", // Display the name after form input
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    // Username Text Field
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter a Username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty"; // Validation for username
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    // Password Text Field
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter a Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty"; // Validation for password
                        } else if (value.length < 6) {
                          return "Password should be at least 6 characters"; // Password length check
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    // Animated login button with a loading state
                    Material(
                      color: context.theme.canvasColor,
                      borderRadius:
                          BorderRadius.circular(changeButton ? 20 : 8),
                      child: InkWell(
                        onTap: () => moveToHome(
                            context), // On Tap, trigger move to home page
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          child: Container(
                            width: changeButton ? 50 : 110,
                            height: 50,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
