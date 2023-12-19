import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yn_flutter/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  _snackBar(text) {
    Get.snackbar("Error", text,
        backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
  }

  void _register() async {
    loading = true;
    bool error = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _snackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _snackBar('The account already exists for that email.');
      }
    } catch (e) {
      loading = false;
      error = true;
      _snackBar(e);
      setState(() {});
    } finally {
      loading = false;
      if (!error) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          _snackBar("Please check your email");
          setState(() {});
        } else {
          Get.off(() => const HomePage());
        }
      }
    }
  }

  void _login() async {
    try {
      loading = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      loading = false;
      if (e.code == "user-not-found") {
        _snackBar("User not found");
      } else if (e.code == "wrong-password") {
        _snackBar("Wrong password");
      } else {
        _snackBar(e.code);
      }
    } finally {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
          const SizedBox(height: 14),
          loading
              ? const CircularProgressIndicator()
              : ElevatedButton.icon(
                  onPressed: () {
                    print(
                        "${_emailController.text}${_passwordController.text}");
                    _login();
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Login"))
        ]),
      ),
    );
  }
}
