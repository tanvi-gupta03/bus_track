import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
class track extends StatefulWidget{
  const track({super.key});

  @override
  State<track> createState() => _trackState();
}

class _trackState extends State<track> {
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
     timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getLocation());
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
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(latitude ?? 0.0, longitude ?? 0.0),
          initialZoom: 15.0,
        ), children: [
          TileLayer(
             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: [busmarker]),
        ]),
    );
  }
}