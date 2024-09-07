
import 'package:flutter/material.dart';
import 'package:sparklig_spectrum/component/Color.dart';
Container textform(controllerText, String Title, TextInputType type,void Function()? onTappassword,bool _isHiddenPassword,String? Function(String?)? validator,Widget? prefixIcon) {
  
    return Container(
      height: 70,
      width: double.infinity,
      child: TextFormField(
        validator: validator,
        // textAlign: TextAlign.center,
        obscureText: type == TextInputType.visiblePassword
            ? _isHiddenPassword
            : false,
        keyboardType: type,
      style: TextStyle(color: secoundrcolor),
        cursorColor: secoundrcolor,
        controller: controllerText,
        decoration: InputDecoration(
          suffixIcon:prefixIcon,
        labelStyle: TextStyle(color: secoundrcolor),
          prefixIcon: type != TextInputType.visiblePassword
              ? SizedBox()
              : InkWell(
                  onTap:onTappassword,
                  child: Icon(
                    _isHiddenPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.blue,
                  ),
                ),
          
          errorStyle: TextStyle(fontSize: 7),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black)),
          
          hintText: Title,
          hintStyle:
              TextStyle(color: Colors.grey, fontFamily: 'Cobe'),
        ),
      ),
    );
  }

  ElevatedButton loginbutton(String title, void Function()? onPressed) {
    return ElevatedButton(
      
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                // side: BorderSide(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            minimumSize: const Size(250, 50),
            backgroundColor: secoundrcolor));
  }

