//صفحة تعرض مشاعر الطفل جيدة سيئة زعلان حمقان
import 'package:child_barcelet/component/Color.dart';
import 'package:flutter/material.dart';

class FelingPage extends StatefulWidget {
  const FelingPage({super.key});

  @override
  State<FelingPage> createState() => _FelingPageState();
}

class _FelingPageState extends State<FelingPage> {
  String feling = "";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      feling = "جيد";
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مشاعر الطفل"),
        backgroundColor: globalcolor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 150,
            child: Image.asset("assets/logo.png"),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              //height: 100,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: secoundrcolor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text(
                "مشاعر الطفل : ${feling}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
