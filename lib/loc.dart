
import 'package:bus_track/driver.dart';
import 'package:bus_track/homem.dart';
import 'package:bus_track/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class locpage extends StatefulWidget{
  const locpage({super.key});

  @override
  State<locpage> createState() => _locpageState();
}

class _locpageState extends State<locpage> {
  final formkey2 = GlobalKey<FormState>();
  bool isrun = false;
  List<String> l2=['1','2','3','4'];
  String drop1='1';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('image/log.jpg'), fit: BoxFit.cover,

        )
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(400, 100, 100, 100),
            child: Card(
              color:  Color.fromARGB(255, 228, 197, 112).withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Form(
                key: formkey2,
                child:Column(
                  children: [
                    SizedBox(height: 50,),
                     DropdownButtonFormField(
                  icon: Icon(Icons.arrow_circle_down),
                              decoration: InputDecoration(
                                labelText: 'Choose Your Role',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                              ),
                          value: drop1,
                          items:l2.map(
                              (e) {
                                return DropdownMenuItem(
                                  
                                  child: Text(e),value: e,);
                          
                            }).toList(), onChanged: (val){
                              setState(() {
                                drop1= val as String;
                              });
                  
                            }),
                            SizedBox(height: 50,),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                    
                      transform: isrun? Matrix4.translationValues(100, 0, 0)
                        : Matrix4.translationValues(0, 0, 0), 
                      
                      
                      child: GestureDetector(
                        onTap:() async{
                          setState(() {
                            isrun=!isrun;
                    
                          });
                          if(isrun){
                            if(formkey2.currentState!.validate()){
                               await Future.delayed(Duration(seconds: 1));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => drive() ));
                            }
                            
                          }
                        },
                        child: Image.asset('image/bus3.jpg',height: 150,width: 100,),
                      ),
              
                      ),
                  ],
                )
                    
              ),
            ),
          ),
        ),
      
    ));
  }
}