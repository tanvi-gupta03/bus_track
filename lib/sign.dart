import 'package:bus_track/homem.dart';
import 'package:bus_track/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
class signup extends StatefulWidget{
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool isloading=false;
  bool isrunning = false;
  final formkey1 = GlobalKey<FormState>();
  TextEditingController _emaill = TextEditingController();
  TextEditingController _passw = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _vehicle = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _start = TextEditingController();
  void getcurrentloc() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied || permission == LocationPermission.deniedForever ){
      print('permision not given');
      LocationPermission asked= await Geolocator.requestPermission(); 
    }
    else{
      Position currentposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    }
  }
  Future<void> signUpWithEmailAndPassword() async{
    try {
      setState(() {
        isloading = true;
      });
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emaill.text,
    password: _passw.text,
    
  );
  setState(() {
        isloading = false;
      });
       Navigator.push(context, MaterialPageRoute(builder: (context) => homemm() ));
} on FirebaseAuthException catch (e) {
  setState(() {
        isloading = false;
      });
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  setState(() {
        isloading = false;
      });
  print(e);
}
  }
  Future<void> savedetails() async{
  try {
      Position currentposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      double latitude = currentposition.latitude;
      double longitude = currentposition.longitude;
        var response =
            await FirebaseFirestore.instance.collection('userslist').add({
          'user_Id': _id.text,
          'user_name': _name.text,
          "password": _passw.text,
          'vehicle_number': _vehicle.text,
          'email': _emaill.text,
          'latitude': latitude,  
          'longitude': longitude,
        });
        print("Firebase response1111 ${response.id}");
        
       
      } catch (exception) {
       
        print("Error Saving Data at firestore $exception");
      }}
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('image/log.jpg'),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(500, 100, 200, 100),
            child: Card(
              color:  Color.fromARGB(255, 228, 197, 112).withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Form(
                key: formkey1,
                child: Column(
                  children: [
                    Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _name,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,
                                ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _emaill,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Email',
                               labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _id,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Role',
                               labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _vehicle,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Bus Number',
                               labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _passw,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Password',
                               labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _start,
                              validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'This field is empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Start Location',
                               labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ) ,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                    SizedBox(height: 60,),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                    
                      transform: isrunning? Matrix4.translationValues(100, 0, 0)
                        : Matrix4.translationValues(0, 0, 0), 
                      
                      
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isrunning=!isrunning;
                    
                          });
                          if(isrunning){
                            if(formkey1.currentState!.validate()){
                              getcurrentloc();
                              signUpWithEmailAndPassword();
                              savedetails();
                               await Future.delayed(Duration(seconds: 1));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => homemm() ));
                            }
                            
                          }
                        },
                        child: Image.asset('image/bus3.jpg',height: 150,width: 100,),
                      ),
              
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}