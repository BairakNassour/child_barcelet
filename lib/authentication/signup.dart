import 'package:child_barcelet/component/widgetofauth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key,});

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController braceletNumberController = TextEditingController();

String _selectedUserType = 'طفل';  // الافتراضي هو طفل
String _selectedGender = 'ذكر';   // الافتراضي هو ذكر
bool _isHiddenPassword = true;

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Form(
            key: formState,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up",
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
                  height: 650,  // زيادة في الارتفاع لتضمين جميع الحقول
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textform(
                          nameController,
                          "الاسم",
                          TextInputType.text,
                          () {},
                          false,
                          (value) {
                            if (value!.isEmpty) {
                              return "الرجاء إدخال الاسم";
                            }
                            return null;
                          },
                          Icon(Icons.person),
                        ),
                        SizedBox(height: 10),
                        textform(
                          ageController,
                          "العمر",
                          TextInputType.number,
                          () {},
                          false,
                          (value) {
                            if (value!.isEmpty || int.tryParse(value) == null) {
                              return "الرجاء إدخال العمر بشكل صحيح";
                            }
                            return null;
                          },
                          Icon(Icons.cake),
                        ),
                        SizedBox(height: 10),
                        // حقل البريد الإلكتروني
                        textform(
                          emailController,
                          "البريد الإلكتروني",
                          TextInputType.emailAddress,
                          () {},
                          false,
                          (value) {
                            if (!value!.contains("@")) {
                              return "الرجاء إدخال بريد إلكتروني صحيح";
                            }
                            return null;
                          },
                          Icon(Icons.email),
                        ),
                        SizedBox(height: 10),
                        // حقل كلمة المرور
                        textform(
                          passwordController,
                          "كلمة المرور",
                          TextInputType.visiblePassword,
                          () {
                            setState(() {
                              _isHiddenPassword = !_isHiddenPassword;
                            });
                          },
                          _isHiddenPassword,
                          (value) {
                            if (value!.length < 8) {
                              return "كلمة المرور يجب أن تكون 8 حروف على الأقل";
                            }
                            return null;
                          },
                          Icon(Icons.lock),
                        ),
                        SizedBox(height: 20),
                        // اختيار نوع المستخدم
                        DropdownButtonFormField<String>(
                          value: _selectedUserType,
                          items: ['طفل', 'عائلة', 'مسن']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedUserType = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "نوع المستخدم",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        // حقل رقم السوار يظهر فقط للعائلة أو المسن
                        if (_selectedUserType == 'طفل' || _selectedUserType == 'مسن')
                          textform(
                            braceletNumberController,
                            "رقم السوار",
                            TextInputType.number,
                            () {},
                            false,
                            (value) {
                              if (_selectedUserType != 'طفل' && value!.isEmpty) {
                                return "الرجاء إدخال رقم السوار";
                              }
                              return null;
                            },
                            Icon(Icons.nfc),
                          ),
                        SizedBox(height: 10),
                        // اختيار الجنس
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: ['ذكر', 'أنثى']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "الجنس",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        // زر التسجيل
                        Container(
                          width: width / 2,
                          child: MaterialButton(
                            color: Colors.blue,
                            child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              var formData = formState.currentState;
                              if (formData!.validate()) {
                                // تنفيذ عملية التسجيل هنا
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
