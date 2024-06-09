import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/screens/email_auth/signup_screen.dart';
import 'package:phone_authentication/screens/phone_auth/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void login()async{
    String email= emailcontroller.text.trim();
    String password= passwordcontroller.text.trim();
    if(email==""|| password == ""){
      print('please fill all the fields');
    }else{
      try{
        UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null){
          Navigator.popUntil(context, (route)=>route.isFirst);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }else{
          print('please fill all the fields');
        }
      }on FirebaseAuthException catch (ex){
        print(ex.code.toString());
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller:  emailcontroller,
                  decoration: InputDecoration(
                    labelText: 'email',
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    labelText: 'password',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: login, child: Text('login')),
                ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));}, child: Text('create an account'),)
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
