import 'package:flutter/material.dart';
import 'package:sparklig_spectrum/authentication/widgetofauth.dart';
import 'package:sparklig_spectrum/component/Color.dart';
import 'package:sparklig_spectrum/view/child/homepagechild.dart';
import 'package:sparklig_spectrum/view/parent/homepage.dart';

import 'singup.dart';
class Login extends StatefulWidget {
  final String type;
  const Login({super.key, required this.type});

  @override
  State<Login> createState() => _LoginState();
}

bool _isHiddenPassword=true;
TextEditingController myipcontrller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();
TextEditingController emailcontroller=TextEditingController();

bool istaken=false;

class _LoginState extends State<Login> {
  bool ignoring = false;
  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

    GlobalKey<FormState> formstate= new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   var width= MediaQuery.of(context).size.width;
   var height= MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: globalcolor,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.center,
                  child: Text("Sparklig Spectrum",style: TextStyle(color: secoundrcolor,fontSize: 30,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0), // يمكنك ضبط قيمة الشعاع حسب الحاجة
                ),
                  padding: EdgeInsets.all(20),
                  
                                    height: 520,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        
                Container(
                  height: 150,
                  child: Image.asset("assets/logo.png")),
                  SizedBox(height:40,),
                
                                        textform(
                              
                                                    emailcontroller,
                                        
                                                    "البريد الالكتروني",
                                        
                                                     TextInputType.emailAddress,
                                        
                                                     () {},
                                                  
                                                  _isHiddenPassword,
                                        
                                                  (value) {
                                                     if (!value!.contains("@")) {
                                                      return "enter a valid email";
                                                     }
                                                     return null;
                                                    },
                                                    Icon(Icons.person,color: Colors.orange,),
                                                  ),
                                                    
                                                  SizedBox(height:height/60,),
                                                  textform(
                                        
                                                    passwordcontroller,
                                        
                                                    "كلمة المرور",
                                        
                                                     TextInputType.visiblePassword,
                                        
                                                     () {
                                                    setState(() {
                                                      _isHiddenPassword=!_isHiddenPassword;
                                                    });
                                                  },
                                                  
                                                  _isHiddenPassword,
                                        
                                                  (value) {
                                                     if (value!.length < 8) {
                                                      return "password must be 8 charcters";
                                                     }
                                                     return null;
                                                    },
                                                    Icon(Icons.lock,color: Colors.orange,),
                                                 
                                                  ),
                                                
                                                  
                                                  SizedBox(height:height/20,),
                                                  !ignoring?
                                                  Container(
                                                    height: height/14,
                                                    width: width/2,
                                                    child: IgnorePointer(
                                                      ignoring: ignoring,
                                                      child: loginbutton(
                                                          
                                                          "Login",
                                                          
                                                          () {
                                                           var formdata=formstate.currentState;
                                                          
                                                           if( formdata!.validate()){
                                                           setIgnoring(!ignoring);
                                                          //  _user_control.login(context,emailcontroller.text,passwordcontroller.text,filteruser(widget.type.toString())).whenComplete((){
                                                              setIgnoring(!ignoring);
                                                          //  });
                                                           if (widget.type=="child") {
                                                                  Navigator.push(context,
                                                                      MaterialPageRoute(builder: (BuildContext context) {
                                                                        return HomePageChild();
                                                                      }));
                                                                  } else if(widget.type=="Parent") {
                                                                    Navigator.push(context,
                                                                      MaterialPageRoute(builder: (BuildContext context) {
                                                                        return HomePageParent();
                                                                      }));
                                                                  
                                                                
                                                                  }else{
                                                                  //   _user_control.registerspecial(emailcontroller.text,passwordcontroller.text,firstnamecontroller.text, 
                                                                  // phonenumbercontroller.text,
                                                                  //  filteruser(widget.type),"ksa", context);
                                                                
                                                                  }
                                                           
                                                          
                                                          
                                                             
                                                           }
                                                        }),
                                                    ),
                                                  ):CircularProgressIndicator(),

                                                  Container(
                                                        width: 300,
                                                        child: MaterialButton(
                                                          child:Text("Sign up"),
                                                          onPressed: () { 
                                                            Navigator.push(context,
                                                                MaterialPageRoute(builder: (BuildContext context) {
                                                              return Signup(type: widget.type,);
                                                            }));
                                                        //  _authentiction_control.login(context, emailcontroller.text, passwordcontroller.text);
                                                        })),
                        
                                      ],
                                    ),
                                  ),
                

               
                SizedBox(height: height/20,),
               
              ],
            ),
          )
          ),
      ),
    );
  }
}
filteruser(String myuser){
    if (myuser=="Parent") {
      return "login_parent";
    } else if(myuser=="child"){
       return "login_children";
    }else{
      return "login_specialist";
    }
  }