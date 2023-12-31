import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minimal/components/container.dart';
import 'package:minimal/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginForm();
  }
}

class LoginForm extends State<LoginScreen> {
  String email = "";
  String password = "";
  bool isLoggedIn = false;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(Routes.menu);
      }
    });
  }

  void doLogin() async {
    _formkey.currentState!.save();

    // Validação do Login
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Erro na autenticação!");
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContainer(
        includeLogo: true,
        title: '',
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Digite o seu email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Digite a senha'),
                obscureText: true,
                onSaved: (newValue) => password = newValue!,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: doLogin, child: const Text('Login')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
