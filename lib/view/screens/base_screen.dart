import 'package:flutter/material.dart';
import 'package:prayer_app/model/user_secure_storage_class.dart';
import 'package:prayer_app/view/screens/log_in_screen.dart';
import 'package:prayer_app/view/screens/main_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  Future<bool> _isLoggedIn() async {
    bool? isChecked = await SecureStorage.readIsSaved("isSaved") == "saved";
    return isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data!
                    ? const MainScreen()
                    : const LogInScreen();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
