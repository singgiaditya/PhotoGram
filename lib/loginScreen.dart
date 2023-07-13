

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtf_app/HomeScreen.dart';
import 'package:mtf_app/shared_pref.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isObscure = true;
  String baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  Future<void> login(String email, String password) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post("${baseUrl}/login",
          data: {"email": email, "password": password});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.data['data']['token']}")));
      SharedPref.pref?.setString("token", "${response.data['data']['token']}");
      if (response.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  height: 20,
                ),
                Text(
                  "Welcome back! Glad to see you, Again!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 32,
                ),
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Your Email"),
                ),
                Container(
                  height: 12,
                ),
                TextFormField(
                  controller: _password,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                              print("${isObscure}");
                            });
                          },
                          icon: Icon(isObscure
                              ? Icons.remove_red_eye
                              : Icons.visibility_off))),
                ),
                Container(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password',
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.black)),
                    onPressed: () {
                      login(_email.text, _password.text);
                    },
                    child: Text("Login"),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      width: 120,
                      height: 2,
                    ),
                    Text("Or Login With"),
                    Container(
                      color: Colors.grey,
                      width: 120,
                      height: 2,
                    )
                  ],
                ),
                Container(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 36,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png"),
                    ),
                    Container(
                      height: 36,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png"),
                    ),
                    Container(
                      height: 36,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/625px-Apple_logo_black.svg.png"),
                    )
                  ],
                ),
                Container(
                  height: 120,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?"),
                    Container(width: 12),
                    Text(
                      "Register Now",
                      style: TextStyle(color: Colors.cyan),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
