
import 'dart:async';

import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/controllers/tracking_controller.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleapis/serviceconsumermanagement/v1.dart';


import 'package:map_location_picker/map_location_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher_string.dart';

class OrderTrackMap extends StatefulWidget {
  const OrderTrackMap({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<OrderTrackMap> createState() => _OrderTrackMapState();
}

class _OrderTrackMapState extends State<OrderTrackMap> {
  TrackingController trackingController = Get.put(TrackingController());
  BillingController billingController = Get.put(BillingController());
  late IO.Socket socket;
  late Map<MarkerId, Marker> _markers;
   Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Completer<GoogleMapController> _controller = Completer();
  

  late  CameraPosition _cameraPosition;
  @override
  void initState() {
    
    super.initState();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
    initMarkers();
    setPolylines();
    initSocket();
    
    
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<void> initSocket() async{
    final Uint8List deliveryIcon = await getBytesFromAsset("assets/icons/tracking_icon.png",100);
    


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
      Marker marker = Marker(
        markerId:const  MarkerId("ID1"),
        icon: BitmapDescriptor.fromBytes(deliveryIcon),
        position: LatLng(
          data["lat"], 
          data["lng"]
          ),
        );
      
        setState(() {
          _markers[const MarkerId("ID1")] = marker;
          
        });
        print("Recieved Value --------------------------- ${data["lat"].toString()}");
      });
    }catch(e){
      if(kDebugMode) print(e.toString());
    }
  }

  void initMarkers() async {
    _cameraPosition = const CameraPosition(target: LatLng((17.726595+17.716140)/2,(83.303757+83.328058)/2),
      zoom: 14.5
    );
    final Uint8List homeIcon = await getBytesFromAsset('assets/icons/home.png', 100);
    final Uint8List shopIcon = await getBytesFromAsset("assets/icons/shop1.png",100);
    Marker shop = Marker(
      markerId: const MarkerId("ID2"),
      icon: BitmapDescriptor.fromBytes(shopIcon),
        
      position: const LatLng(
        17.743855, 
        83.328058
      ),
    );
      
    Marker home = Marker(
      markerId: const MarkerId("ID3"),
      icon: BitmapDescriptor.fromBytes(homeIcon), 
      position: const LatLng(
        17.716140, 
        83.315845
        ),
    );
    setState(() {
      _markers[const MarkerId("ID2")] = shop;
      _markers[const MarkerId("ID3")] = home;
    });

  }

  void setPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA12cj1hCvSAsX4SAQdrqSieirOQYsmQTU", 
      const PointLatLng(17.743855,83.328058), 
      const PointLatLng(17.716140, 83.315845), 
    );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    }
    
  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, 
        width: 5,
        color: Constants.customRedLight,  
        points: polylineCoordinates
      );
    polylines[id] = polyline;
    setState(() {});
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
                initialCameraPosition:_cameraPosition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(_markers.values),
                polylines: Set<Polyline>.of(polylines.values),
              ),
            ),
            Positioned(
              child: Container(
                width: w,
                height: h * 0.15,
                decoration: BoxDecoration(
                  color: Constants.customRed,
                  
                  boxShadow:const [
                    BoxShadow(color: Color.fromARGB(255, 194, 194, 194), blurRadius: 20)
                  ]
                ),
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                        //     SizedBox(width: w * 0.25,),
                        //     Text("AnewMeat",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white),),
                        //     SizedBox(width: w * 0.35,)
                        //   ],
                        // ),
                        const SizedBox(height: 5,),
                        const Text("Order is Right on the Way 🤘", style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                        const SizedBox(height: 6,),
                        Container(
                          width: w * 0.4,
                          height: h * 0.03,
                         
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                             color: Color.fromARGB(61, 255, 255, 255),
                          ),
                          child: Center(
                            child: const Text("Arriving in 20 Min", style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.white,fontWeight: FontWeight.bold)
                            ),
                          )),
                      ],
                    ),
                  ),
                ),  
              ),
              Positioned(
                top: h * 0.75,
                child: Container(
                  width: w,
                  height: h * 0.25,
                  padding: EdgeInsets.all(10),
                  decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 15),
                    ],
                  ),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: w,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300,width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 236, 236, 236),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.person_2_rounded,color: Constants.customRed,),
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    Container(
                                      width: w * 0.62,
                                      height: h * 0.05,
                                      child: const Center(child: Text("Mohan Rao is on the way to deliver your fresh Meat !!",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),)),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: (){
                                    launchUrlString("tel://7997435603");
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromARGB(255, 236, 236, 236)
                                    ),
                                    child: Icon(Icons.call, color: Constants.customGreen,)
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            width: w,
                            height: h * 0.12,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300,width: 1)
                            ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/icons/address.png",width: 20,),
                                    SizedBox(width: 10,),
                                    Text("Delivering to Address",style: TextStyle(fontWeight: FontWeight.bold,),),
                                  ],
                                ),
                                SizedBox(height:10,),
                                Container(
                                  width: w,
                                  height: 1,
                                  color: const Color.fromARGB(255, 220, 220, 220),
                                ),
                                SizedBox(height: 10,),
                                Text(billingController.orderModel!.orders[widget.index].deliveryAddress.toString(),style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),)

                              ],
                            )
                          )
                          
                        ],
                      ),
                    ),
                  ),
                
            
          ],
        ),
      ),
      
    );
  }
}