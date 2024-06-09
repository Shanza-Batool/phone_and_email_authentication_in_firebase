import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/screens/phone_auth/verify_otp.dart';

class SigninWithPhone extends StatefulWidget {
  const SigninWithPhone({super.key});

  @override
  State<SigninWithPhone> createState() => _SigninWithPhoneState();
}

class _SigninWithPhoneState extends State<SigninWithPhone> {
  TextEditingController phone_controller= TextEditingController();
  void sendOTP()async{
   String phone = "+92"+phone_controller.text.trim();
   await FirebaseAuth.instance.verifyPhoneNumber(
     phoneNumber: phone,
     codeSent: (verificationId, resendToken){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyOtp(verificationId: verificationId,)));
     },
     verificationCompleted: (credential){},
     verificationFailed: (ex){
       print(ex.code.toString());
     },
     codeAutoRetrievalTimeout: (verificationId){},
    timeout: Duration(seconds:30 )
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller:phone_controller ,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){sendOTP();}, child:Text('Sign in'),),
            ],
          ),
        ),
      ),
    );
  }
}
