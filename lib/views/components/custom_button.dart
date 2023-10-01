import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton({super.key,required this.title,required this.height,required this.width,required this.callback});
  String title;
  double height;
  double width;
  final VoidCallback callback;
  
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

static const double _shadowHeight = 16;
double _position = 4;
  
@override
Widget build(BuildContext context) {
 double height = 64 - _shadowHeight;
 return Scaffold(
   body: Center(
     child: GestureDetector(
       onTapUp: (_) {
         setState(() {
           _position = 4;
         });
       },
       onTapDown: (_) {
         setState(() {
           _position = 0;
         });
       },
       onTapCancel: () {
         setState(() {
           _position = 4;
         });
       },
       onTap:() => widget.callback(),
       child: SizedBox(
         height: height + _shadowHeight,
         width: widget.width,
         child: Stack(
           children: [
             Positioned(
               bottom: 0,
               child: Container(
                 height: height,
                 width: widget.width,
                 decoration:const BoxDecoration(
                   color: Color.fromARGB(255, 114, 0, 0),
                   borderRadius: BorderRadius.all(
                     Radius.circular(16),
                   ),
                 ),
               ),
             ),
             AnimatedPositioned(
               curve: Curves.easeIn,
               bottom: _position,
               duration:const Duration(milliseconds: 70),
               child: Container(
                 height: height,
                 width: widget.width,
                 decoration:const BoxDecoration(
                   color: Color.fromARGB(255, 206, 53, 65),
                   borderRadius: BorderRadius.all(
                     Radius.circular(16),
                   ),
                 ),
                 child: Center(
                   child: Text(
                     widget.title,
                     style:const TextStyle(
                       color: Colors.white,
                       fontSize: 22,
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
   ),
 );
}
}