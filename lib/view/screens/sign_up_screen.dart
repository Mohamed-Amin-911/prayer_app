import 'package:flutter/material.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/constants/text_style.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/view/screens/log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _username = "";
  bool validator = true;
  @override
  Widget build(BuildContext context) {
    Sizeconfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 106 * Sizeconfig.verticalBlock),
                Text(
                  "Signup",
                  style: appStyle(
                      fw: FontWeight.bold, size: 34, color: Colors.black),
                ),
                SizedBox(height: 73 * Sizeconfig.verticalBlock),
                TextFormField(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2D2D2D),
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Username',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9B9B9B))),
                  onSaved: (value) => _username = value!,
                ),
                SizedBox(height: 23 * Sizeconfig.verticalBlock),
                TextFormField(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2D2D2D),
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9B9B9B))),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 23 * Sizeconfig.verticalBlock),
                TextFormField(
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff2D2D2D),
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9B9B9B))),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Password must contain a capital letter';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password must contain a number';
                    }
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                      return 'Password must contain a special character';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 35 * Sizeconfig.verticalBlock),
                SizedBox(
                  height: 48,
                  width: 343,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        SecureStorage.writeData("username", _username);
                        SecureStorage.writeData("email", _email);
                        SecureStorage.writeData("password", _password);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogInScreen(),
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signup failed!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: const Color(0xff52BF95)),
                    child: Text(
                      "SIGNUP",
                      style: appStyle(
                          fw: FontWeight.w400, size: 14, color: Colors.white),
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
