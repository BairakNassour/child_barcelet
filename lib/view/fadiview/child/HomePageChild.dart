//بدنا هون خريطة بتعرض موقع الطفل على الخريطة بحيث تكون
//موافقة للون التطبيق العام وما ننسىفكرة الستايل الموحد 
//فيك تعمل رن لشغلك ومن ثم ترجع صفحة تسجيل الدخول هيي بتابع المين
// ما تنسى تخزن الموقع الحالي بمتحول بحيث اذا بدك تبعت الموقع لك تلاتين ثانية جهز
//انت بحيث اذا طلع الموقع من التطبيق ترفع م ن هون مباشرة
import 'package:flutter/material.dart';

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // اكتب الكود هون
          ),
        ),
      ),
    );
  }
}