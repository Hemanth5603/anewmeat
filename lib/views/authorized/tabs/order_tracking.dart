import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderTrackPage extends StatefulWidget {
  const OrderTrackPage({super.key});

  @override
  State<OrderTrackPage> createState() => _OrderTrackPageState();
}

class _OrderTrackPageState extends State<OrderTrackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Placed Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body:const SafeArea(
        child:Center(
          child: Text("You Haven't Placed any order!",style: TextStyle(fontSize: 16),),
        ) 
      )
    );
  }
}