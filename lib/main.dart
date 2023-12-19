import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yn_flutter/pages/signin_page.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    if (FirebaseAuth.instance.currentUser != null) isLogin = true;
    print("isLogin: $isLogin");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YN Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // scaffoldBackgroundColor: Colors.grey,
      ),
      home: isLogin ? const HomePage() : const SignInPage(),
    );
  }
}
