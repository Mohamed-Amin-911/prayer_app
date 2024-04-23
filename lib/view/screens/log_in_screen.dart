import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prayer_app/config/size_config.dart';
import 'package:prayer_app/constants/text_style.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/provider/login_provider.dart';
import 'package:prayer_app/view/screens/main_screen.dart';
import 'package:prayer_app/view/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

const storage = FlutterSecureStorage();

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

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
                  "Login",
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
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9B9B9B))),
                  onSaved: (value) => _email = value!,
                  onChanged: (value) => _email = value,
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
                  onSaved: (value) => _password = value!,
                  onChanged: (value) => _password = value,
                ),
                SizedBox(height: 23 * Sizeconfig.verticalBlock),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<LoginProvider>(context, listen: false)
                              .setIsChecked = !(Provider.of<LoginProvider>(
                                  context,
                                  listen: false)
                              .getIsChecked);
                        });
                      },
                      child: Container(
                        width: 19,
                        height: 19,
                        color: const Color(0xffB4E8D5),
                        child: Icon(
                          size: 20,
                          Icons.check,
                          color:
                              Provider.of<LoginProvider>(context).getIsChecked
                                  ? Colors.white
                                  : const Color(0xffB4E8D5),
                        ),
                      ),
                    ),
                    SizedBox(width: 13 * Sizeconfig.horizontalBlock),
                    Text(
                      "Keep Me Logged In",
                      style: appStyle(
                          fw: FontWeight.w400, size: 14, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 35 * Sizeconfig.verticalBlock),
                SizedBox(
                    height: 48,
                    width: 343,
                    child: ElevatedButton(
                      onPressed: () async {
                        String email = await SecureStorage.readData("email");
                        String password =
                            await SecureStorage.readData("password");

                        if (_email.trim() == email.trim() &&
                            _password == password) {
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()));
                            Provider.of<LoginProvider>(context, listen: false)
                                    .getIsChecked
                                ? SecureStorage.writeIsSaved("isSaved", "saved")
                                : SecureStorage.writeIsSaved(
                                    "isSaved", "notSaved");
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid email or password'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: const Color(0xff52BF95)),
                      child: Text(
                        "LOGIN",
                        style: appStyle(
                            fw: FontWeight.w400, size: 14, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 35 * Sizeconfig.verticalBlock),
                SizedBox(
                    height: 48,
                    width: 343,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color(0xff52BF95), width: 2),
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Colors.white),
                      child: Text(
                        "SIGNUP",
                        style: appStyle(
                            fw: FontWeight.w400,
                            size: 14,
                            color: const Color(0xff52BF95)),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
