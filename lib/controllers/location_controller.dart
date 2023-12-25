
import 'dart:async';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_location_picker/map_location_picker.dart';




class LocationController extends GetxController {
  UserController userController = Get.put(UserController());

  /*getCurrentLocation() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    final GoogleMapController? mapController = await controller?.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnabled = await location.serviceEnabled();

    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
      if(!serviceEnabled){
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    if(permissionGranted == loc.PermissionStatus.granted){
      location.changeSettings(accuracy: loc.LocationAccuracy.high);

      currentPosition = await location.getLocation();
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentPosition!.latitude!,currentPosition!.longitude!),zoom: 16)
      ));
      
    }
  }
*/

  Future<void> getCurrentPosition() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Please keep your location enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Location Permission denied!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location Permission denied Forever!');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      userController.userModel.value.latitute = position.latitude;
      userController.userModel.value.longitude = position.longitude;
      print("lat: ${userController.userModel.value.latitute.toString()}");
      print("long: ${userController.userModel.value.longitude.toString()}");
      print(position.latitude);
      
    } catch (e) {
      print(e);
    }
  }

  

}