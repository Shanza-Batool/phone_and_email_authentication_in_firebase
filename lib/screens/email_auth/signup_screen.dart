import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller= TextEditingController();
  TextEditingController confirmpassword_controller= TextEditingController();

  void createAccount()async{
    String email= email_controller.text.trim();
    String password= password_controller.text.trim();
    String confirmPassword = confirmpassword_controller.text.trim();

    if(email == "" || password== ""|| confirmPassword ==""){
      print("please fill all the fields");
    }else if(password!= confirmPassword){
      print('passwords do not match');
    }else{
     try{
       UserCredential userCredential= await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
       print('user created');
       if(userCredential.user!=null){
         Navigator.pop(context);
       }
     }on FirebaseAuthException catch(ex){
        print(ex.code.toString());
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup screen'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: email_controller,
                      decoration: InputDecoration(
                        labelText: 'email',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: password_controller,
                      decoration: InputDecoration(
                        labelText: 'password',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: confirmpassword_controller,
                      decoration: InputDecoration(
                        labelText: 'confirm password',
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){createAccount();}, child: Text('create account')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
