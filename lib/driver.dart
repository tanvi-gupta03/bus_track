import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
class drive extends StatefulWidget{
  drive({super.key});

  @override
  State<drive> createState() => _driveState();
}

class _driveState extends State<drive> {
  late MapController mapController;
  double latitude=0.0;
  double longitude=0.0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Marker busmarker;
  late Timer timer;
@override
  void initState() {
    super.initState();
    mapController = MapController();
    getLocation();
     busmarker = Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(latitude, longitude),
      child:  Container(
        child: Icon(
          Icons.directions_bus,
          color: Colors.blue,
        ),
      ),
    );
     timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      print('time repeat');
       getLocation();});
  }
  Future<void> getLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
         busmarker = Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(latitude, longitude),
      child:  Container(
        child: Icon(
          Icons.directions_bus,
          color: Colors.blue,
        ),
      ),
    );
    savedet();
      });
      Future.delayed(Duration(seconds: 5), getLocation);
    } catch (e) {
      print("Error getting location: $e");
    }
  }
  Future<void> savedet() async {
    await firestore.collection('loc').doc('current').set({
      'latitude' : latitude,
      'longitude': longitude,
    });
  }
   @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SingleChildScrollView(
        child: SizedBox(height: MediaQuery.of(context).size.height,

          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options:MapOptions(
                    initialCenter: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                    initialZoom: 15.0,
              
                  ) ,
              
                  
                   children: [
                    TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.bus_track',
            subdomains: ['a','b','c'],
          ),
          MarkerLayer(markers: [ busmarker]
          ),
          
                   ]
              
                   ),
                   
              ),
             FloatingActionButton(
            onPressed: () {
              getLocation();
              mapController.move(LatLng(latitude ?? 0.0, longitude ?? 0.0), 15.0);
            },
            child: Icon(Icons.my_location,size: 60,),
          ),
            ],
          ),
        ),
      )
      );
  }
}