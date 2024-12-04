import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'register_page.dart';

import '../app_helper.dart';
import 'home_page.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email=TextEditingController();
  TextEditingController password= TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  //final GlobalKey<FormState> _formKey1=GlobalKey<FormState>();
  bool isLoading =false;

  Future<void> login(String username, String password) async {
    Uri url = Uri.parse("${AppHelper.baseUrl}login");

    final body = jsonEncode({
      "username": username,
      "password": password,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      await AppHelper.storeToken(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const HomePage()),
      );
    } else {
      throw Exception('Failed to login and retrieve token');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:const Text("Log In Page", style:TextStyle(fontSize: 25, color:Colors.purple)),
          centerTitle: true,
        ),
        body:  isLoading?const Center(
          child: CircularProgressIndicator(),)
            :SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,

            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    // const Center(
                    //   child: CircleAvatar(
                    //     radius: 100,
                    //     backgroundImage: AssetImage("assets/images/logo.png"),
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child:Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Login to continue using the app",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Email",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Enter your email",
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
                                  return 'Please enter email';
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
                              controller: password,

                              decoration: InputDecoration(
                                hintText: "Enter your password",
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
                                          onPressed: ()async {
                                            if(_formKey.currentState!.validate()) {
                                              login(email.text, password.text);
                                            }
                                          },
                                          child: const Text("Log in"),
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
                                  const Text("Don't have an account? "),
                                  InkWell(
                                    onTap:(){Navigator.pushReplacement(context,MaterialPageRoute(
                                        builder: (context) => const Register()),);},
                                    child: const Text.rich(
                                      TextSpan(
                                        text: "Register",
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
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}

