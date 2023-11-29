import 'package:bus_track/driver.dart';
import 'package:bus_track/firebase_options.dart';
import 'package:bus_track/homem.dart';
import 'package:bus_track/loc.dart';
import 'package:bus_track/sign.dart';
import 'package:bus_track/tracker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
  
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'bus_tracker',
      debugShowCheckedModeBanner: false,
      home: homemm(),
      
    );

  }



}


