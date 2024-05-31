import 'dart:async';

import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/tracking_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:map_location_picker/map_location_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OrderTrackMap extends StatefulWidget {
  const OrderTrackMap({super.key});

  @override
  State<OrderTrackMap> createState() => _OrderTrackMapState();
}

class _OrderTrackMapState extends State<OrderTrackMap> {
  TrackingController trackingController = Get.put(TrackingController());
  late IO.Socket socket;
  late Map<MarkerId, Marker> _markers;
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(target: LatLng(17.7096224,83.3254949),
    zoom: 14
  );
  @override
  void initState() {
    
    super.initState();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    initSocket();
  }

  Future<void> initSocket() async{
    try{
      socket = IO.io("https://anewmeat.onrender.com/", <String, dynamic>{
        'transports' : ['websocket'],
        'autoConnect': true,
      });

      socket.connect();
      socket.onConnect((data) => {
        if(kDebugMode) print('Connected :::::::::: ${socket.id}')
      });
      if(kDebugMode) print("Socket connected ::::::::::::::::: ${socket.connected}");
      socket.emit("connected",7997435603);
      socket.on("getLocation",(data) async {
        if(kDebugMode) print("Recieved data  ---------------------------------- ${data.toString()}");
        if(kDebugMode) print(data["lat"]);
        if(kDebugMode) print(data["lng"]);
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(data["lat"] ,data["lng"]),
              zoom: 17
            ),
          )
        );
      var deliveryIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size : Size(6,6)), "assets/icons/delivery.png");
      var homeIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(8,8)), "assets/icons/home.png");
      var shopIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(6,6)), "assets/icons/shop.png");
      Marker marker = Marker(
        markerId: MarkerId("ID1"),
        icon: deliveryIcon,
        position: LatLng(
          data["lat"], 
          data["lng"]
          ),
      );
      Marker shop = Marker(
        markerId: MarkerId("ID2"),
        icon: shopIcon, 
        position: const LatLng(
          17.726595, 
          83.303757
          ),
      );
      Marker home = Marker(
        markerId: MarkerId("ID3"),
        icon: homeIcon, 
        position: const LatLng(
          17.716140, 
          83.315845
          ),
      );
      
        setState(() {
          _markers[const MarkerId("ID1")] = marker;
          _markers[const MarkerId("ID2")] = shop;
          _markers[const MarkerId("ID3")] = home;
        });
        print("Recieved Value --------------------------- ${data["lat"].toString()}");
      });
    }catch(e){
      if(kDebugMode) print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: w,
              height: h,
              child: GoogleMap(
                initialCameraPosition: trackingController.cameraPosition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(_markers.values),
              ),
            ),
            Positioned(
              child: Container(
                width: w,
                height: h * 0.1,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(color: const Color.fromARGB(255, 194, 194, 194), blurRadius: 20)
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top :30.0, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Track Order", style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold,color: Constants.customRed)),
                      Text("Order ID #ORD_122533356", style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: const Color.fromARGB(255, 200, 200, 200))),
                    ],
                  ),
                ),),  
              ),
              Positioned(
                top: h * 0.7,
                child: Container(
                  width: w,
                  height: h * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 15),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Order is On the Way !", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black),),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 195, 195, 195),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Container(
                              width: w * 0.68,
                              height: h * 0.05,
                              child: const Center(child: Text("Mohan Rao is on the way to deliver your fresh Meat !!",style: TextStyle(fontWeight: FontWeight.w400),)),
                            ),
                             Icon(Icons.call, color: Constants.customGreen,)
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      
    );
  }}