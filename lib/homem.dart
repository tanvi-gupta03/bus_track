import 'package:bus_track/driver.dart';
import 'package:bus_track/loc.dart';
import 'package:bus_track/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homemm extends StatefulWidget{
  const homemm({super.key});

  @override
  State<homemm> createState() => _homemmState();
}

class _homemmState extends State<homemm> {
  _homemmState(){
    drop=l1[0];
  }
  final l1= ['parents','driver','student'];
  String drop ='';
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  Color _buttonColor = Color.fromARGB(255, 228, 197, 112).withOpacity(0.5); // Initial background color
  final Duration _animationDuration = Duration(milliseconds: 50);
  void _toggleColor() {
    setState(() {
      _buttonColor = _buttonColor == Color.fromARGB(255, 228, 197, 112).withOpacity(0.5) ? Color.fromARGB(255, 234, 190, 255).withOpacity(0.5) : Color.fromARGB(255, 228, 197, 112).withOpacity(0.5);
    });
  }
  void _showdialog(context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Information About The App'),
        content: Text('"Introducing [Bus Track], the innovative bus tracking app designed to revolutionize your daily commute. Say goodbye to uncertainty and hello to a new era of stress-free travel. With real-time GPS tracking, [Your App Name] keeps you informed about the exact location and arrival times of your bus, ensuring you never miss a ride or waste a minute waiting.'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.cancel)))
        ],
      );
    });
  }
  Future<void> signInWithEmailAndPassword() async{
    try {
      setState(() {
        isloading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _controller.text,
    password: _pass.text
  );
  setState(() {
        isloading = false;
      });
       if(drop=='driver'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => drive()), 
      );
       }
       else if(drop == 'student'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => locpage()), 
      );
       }
       else if(drop =='parents'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => locpage()), 
      );
       }
}
 on FirebaseAuthException catch (e) {
  setState(() {
        isloading = false;
      });
  if (e.code == 'user-not-found') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wrong email provided for that user.')
        )
        );

   
  } else if (e.code == 'wrong-password') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wrong password provided for that user.')
        )
        );
  }
}catch (e) {
      // Handle other exceptions here
      print(e.toString());
       ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('An error occurred: $e'),
    ),
  );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body: SingleChildScrollView(
        child: DecoratedBox(decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('image/log.jpg'),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
                  duration: _animationDuration,
                  decoration: BoxDecoration(
                    color: _buttonColor,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(onPressed: (){
                          _toggleColor();
                          _showdialog(context);
                          
                        }, 
                        style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Set button's background to transparent
                        shadowColor: Colors.transparent, // Disable button shadow
                      ),
                        child: Text('CLICK To READ MORE',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        ),
                    
                        ),
                  ),
        
                ),
              ),
              SizedBox(width: 30,),
              Text('Stay on track, on time, and in control.',
              style: TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                color:Colors.black,
              ),
              ),
              SizedBox(height: 3,),
              Text('[Bus Track] - Redefining your daily commute',
              style: TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                color:Colors.black,
              ),
              ),
              SizedBox(height: 2,),
              Padding(
                padding: const EdgeInsets.fromLTRB(600, 100, 200, 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    color:  Color.fromARGB(255, 228, 197, 112).withOpacity(0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child: Form(
                          key: formkey,
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0,left: 35.0),
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_circle_down),
                          decoration: InputDecoration(
                            labelText: 'Choose Your Role',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                          ),
                          value: drop,
                          items: l1.map(
                          (e) {
                            return DropdownMenuItem(
                              
                              child: Text(e),value: e,);
                      
                        }).toList(), onChanged: (val){
                          setState(() {
                            drop=val as String;
                          });
                        }),
                      ),
                      SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(right: 35.0 ,left: 35.0),
                          child: TextFormField(
                            controller: _controller,
                            validator: (text){
                              if(text== null || text.isEmpty){
                                return 'email is empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'write your email address here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.purple,
                                  
                                  
                                  ),
                                )
                              ),
                              
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0,left: 35.0),
                          child: TextFormField(
                            
                            controller: _pass,
                            validator: (text){
                                if(text== null || text.isEmpty){
                                  return 'password is empty';
                                }
                                return null;
                              },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'write your password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: Colors.purple
                                
                                  
                                  ),
                    
                                  )
                                  ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: (){
                            if(formkey.currentState!.validate()){
                              signInWithEmailAndPassword();
                              navigatetopage();
                            }
                          }, 
                          child:isloading ? Center(child: CircularProgressIndicator(color: Colors.black,)):
                           Text('LOGIN',style: TextStyle(color: Colors.black) ,),
                           style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 245, 237, 171))
                           ),
                           ),
                           SizedBox(height: 40,),
                           ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                           }, child: Text('Sign Up',style: TextStyle(color: Colors.black) ,),
                           style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                            backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 245, 237, 171))
                           ),
                           ),
                           
                      ],
                    ),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      
        
        ),
      ),
      
    );
  }
  void navigatetopage(){
  if(drop=='driver'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => drive()), 
      );
       }
       else if(drop == 'student'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => locpage()), 
      );
       }
       else if(drop =='parents'){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => locpage()), 
      );
       }
}
}
