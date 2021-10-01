import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterchat/widgets/authform.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email,
    String name,
    String password,
    bool isLogin,
    BuildContext ctx
  ) async {
    UserCredential userCredential;
    try {
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (error) {
      var message = "Please Enter valid credential";
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    }
    catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        body: AuthForm(_submitAuthForm));
  }
}
