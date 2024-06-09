import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  const VerifyOtp({super.key, required this.verificationId});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otp_controller= TextEditingController();

  void verifyOTP()async{
  String otp = otp_controller.text.trim();
  PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otp);
  try{
   UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
   if(userCredential.user!=null){
     Navigator.popUntil(context, (route)=>route.isFirst);
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

   }
  }on FirebaseAuthException catch(ex){
    print(ex.code.toString());
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: otp_controller,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Enter OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){verifyOTP();}, child: Text('verify')),
            ],
          ),
        ),
      ),
    );
  }
}
