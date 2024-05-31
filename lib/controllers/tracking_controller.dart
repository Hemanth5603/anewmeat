import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class TrackingController extends GetxController{

  late IO.Socket socket;
  late Map<MarkerId, Marker> markers;
  Completer<GoogleMapController> controller = Completer();

  CameraPosition cameraPosition = const CameraPosition(target: LatLng(17.7096224,83.3254949),zoom: 14);

  @override
  void onInit() {
    super.onInit();
    markers = <MarkerId, Marker>{};
    markers.clear();
    initSocket();
  }


  Future<void> initSocket() async{
    try{
      socket = IO.io("https://anewmeat.onrender.com/getLocation",<String,dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      socket.connect();
      
      /*socket.on("position-change", (data) async{
        var latlng = jsonDecode(data);
        final GoogleMapController controller = await controller.future;
        controller.animateCamera(
          camera
          CameraPosition(
            target: LatLng(lat)
          )
        )
      });*/

    }catch(e){
      if(kDebugMode) print(e.toString());
    }
  }
}