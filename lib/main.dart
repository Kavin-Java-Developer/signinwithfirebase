import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_firebase_auth/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();

  final url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCnlcxvbW7yMuC-vs8dx_X9W6w4JMn3T3U';

  Future<void> SignIn() async {
    final email = emailcontroller.text;
    final password = passwordcontroller.text;

    final res = await http.post(
      Uri.parse(url),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final result = json.decode(res.body);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Get.to(() => HomePage());
    } else {
      Get.snackbar(
        'Error',
        'Invalid User Credentials!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    print(res.body.toString());
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: SignIn,
                  child: Text(
                    'sign in',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
