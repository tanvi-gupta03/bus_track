
import 'package:bus_track/loc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class loginPage extends StatefulWidget{
  
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pass = TextEditingController();
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
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => locpage()), 
      );
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
      backgroundColor: Color.fromARGB(255, 126, 201, 236),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Image.asset('image/bus3.jpg', height: 200,width: 200,)
                ),
                SizedBox(height: 50),
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
                      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0),
                        
                        
                        ),
                      )
                    ),
                    
                  keyboardType: TextInputType.name,
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
                        borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0),
                      
                        
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
                  }
                }, 
                child:isloading ? Center(child: CircularProgressIndicator(color: Colors.black,)):
                 Text('LOGIN',style: TextStyle(color: Colors.black) ,),
                 style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 245, 237, 171))
                 ),
                 ),
                 
            ],
          ),
        ),
      ),
    );

  }
}
