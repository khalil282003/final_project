import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../app_helper.dart';
import 'login_page.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username=TextEditingController();

  TextEditingController password=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:const Text("Sign Up Page", style:TextStyle(fontSize: 25, color:Colors.purple)),
          centerTitle: true,
        ),
        body: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Form(
                      key: _formkey,
                      child:Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Sign Up to continue using the app",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Username",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(

                              controller: username,
                              decoration: InputDecoration(
                                hintText: "Enter a user name",
                                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            const Text(
                              "Password",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Enter a password",
                                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                          height: 40,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                          color: Colors.purple,
                                          textColor: Colors.white,
                                          onPressed: () async{
                                            if(_formkey.currentState!.validate()) {
                                              registerUser(context,  username.text, password.text);
                                            }
                                          },
                                          child: const Text("Sign Up"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            //Text("Don't have an account", style: TextStyle(fontSize: 15),)
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account? "),
                                  InkWell(
                                    onTap:(){Navigator.pushReplacement(context,MaterialPageRoute(
                                        builder: (context) => const LogIn()),);},
                                    child: const Text.rich(
                                      TextSpan(
                                        text: "Log In",
                                        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
        )
    );
  }
}
void registerUser(BuildContext context, String uname, String pass) async {
  String username = uname.trim();

  String password = pass;

  // Perform validation
  if (username.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Registration failed. Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  // Prepare the request body
  Map<String, String> requestBody = {
    "username": username,
    "password": password,
  };

  // Send the request
  Uri url = Uri.parse("${AppHelper.baseUrl}register");
  try {
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"}, // Set the appropriate header
      body: json.encode(requestBody), // Encode the body as JSON
    );

    if (response.statusCode == 201) {
      // Registration successful, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogIn()),
      );
    } else {
      // Registration failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Registration failed. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (error) {
    // Handle network or other errors
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}