import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class TrackingController extends GetxController{

  late IO.Socket socket;
  late Map<MarkerId, Marker> _markers;
   Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  Completer<GoogleMapController> _controller = Completer();

  @override
  void onInit() {
    super.onInit();
    _markers = <MarkerId, Marker>{};
    _markers.clear();
   
   
  }
}


  