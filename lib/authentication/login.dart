import 'package:child_barcelet/authentication/signup.dart';
import 'package:child_barcelet/component/widgetofauth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key,});

  @override
  State<Login> createState() => _LoginState();
}

bool _isHiddenPassword = true;
TextEditingController passwordcontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();

bool istaken = false;

class _LoginState extends State<Login> {
  bool ignoring = false;

  void setIgnoring(bool newValue) {
    setState(() {
      ignoring = newValue;
    });
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Child Barcelet",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0), 
                  ),
                  padding: EdgeInsets.all(20),
            
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        child: Image.asset("assets/logo.png"),
                      ),
                      SizedBox(height: 40),
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
                        Icon(Icons.person),
                      ),
                      SizedBox(height: height / 60),
                      textform(
                        passwordcontroller,
                        "كلمة المرور",
                        TextInputType.visiblePassword,
                        () {
                          setState(() {
                            _isHiddenPassword = !_isHiddenPassword;
                          });
                        },
                        _isHiddenPassword,
                        (value) {
                          if (value!.length < 8){
                            return "password must be 8 characters";
                          }
                          return null;
                        },
                        Icon(Icons.lock),
                      ),
                      SizedBox(height: height / 20),
                      !ignoring
                          ? Container(
                              height: height / 14,
                              width: width / 2,
                              child: IgnorePointer(
                                ignoring: ignoring,
                                child: loginbutton(
                                  "Login",
                                  () {
                                    var formdata = formstate.currentState;

                                    if (formdata!.validate()) {
                                      setIgnoring(!ignoring);
                                      // تنفيذ تسجيل الدخول، وتعطيل الإشارة مع إكمال العملية
                                      // مثال: 
                                      // _user_control.login(context,emailcontroller.text,passwordcontroller.text)
                                      // .whenComplete(() {
                                      //    setIgnoring(!ignoring);
                                      // });
                                    }
                                  },
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
                          SizedBox(height: 20,),

                      Container(
                        height: height / 14,
                              width: width / 2,
                        child: loginbutton(
                           "Sign up",
                            () {
                              Navigator.push(context,
                                    MaterialPageRoute(builder: (BuildContext context) {
                                  return SignUp();
                                }));
                            
                             },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

