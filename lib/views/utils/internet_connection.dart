import 'package:flutter/material.dart';

class InternetConnectionScreen extends StatelessWidget {
  const InternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("assets/icons/no-wifi.png",)
              ),
              const SizedBox(height: 10,),
              const Text("No Internet Connection",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const SizedBox(height:5,),
              const Text("Please Try again",style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,)
            ],
          )
        ),
      )
    );
  }
}