import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/screens/email_auth/login_screen.dart';
import 'package:phone_authentication/screens/email_auth/signup_screen.dart';
import 'package:phone_authentication/screens/phone_auth/signin_with_phone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void Logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route)=>route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SigninWithPhone()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){Logout();}, icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
