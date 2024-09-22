import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapScreenSuper extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenSuper> {
  late GoogleMapController mapController;
  StreamSubscription<Position>? positionStream;

  // الموقع الحالي
  double lat = 0.0;
  double lon = 0.0;

  // قائمة لتخزين إحداثيات المواقع
  List<LatLng> movementHistory = [];

  @override
  void initState() {
    super.initState();

    // بدء تتبع الموقع عند بداية التطبيق
    _determinePosition().then((value) {
      setState(() {
        lat = value.latitude;
        lon = value.longitude;
        _goToTheNewPosition();
        // تخزين الموقع الأول
        _storeLocation(LatLng(lat, lon));
      });
    });

    // الاشتراك في تغيير الموقع
    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // تحديث الموقع بعد كل 10 أمتار
      ),
    ).listen((Position position) {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
        _goToTheNewPosition();
        // تخزين الموقع عند كل تحديث
        _storeLocation(LatLng(lat, lon));
      });
    });
  }

  @override
  void dispose() {
    positionStream?.cancel(); // إلغاء الاشتراك عند الخروج من الشاشة
    super.dispose();
  }

  // دالة لتخزين الموقع في قائمة
  void _storeLocation(LatLng newLocation) {
    movementHistory.add(newLocation); // تخزين الإحداثيات في القائمة
    print("Saved Location: lat = ${newLocation.latitude}, lng = ${newLocation.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع موقع المسن"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lon), // الموقع الابتدائي
                zoom: 15.0,
              ),
              myLocationEnabled: true, // إظهار الموقع الحالي
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("الموقع الحالي:"),
                Text("Latitude: $lat, Longitude: $lon"),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // عرض المواقع المحفوظة
                    _showSavedLocations();
                  },
                  child: Text("عرض المواقع المحفوظة"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة لإظهار المواقع المحفوظة
  void _showSavedLocations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("المواقع المحفوظة"),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: movementHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("موقع ${index + 1}:"),
                  subtitle: Text(
                      "Latitude: ${movementHistory[index].latitude}, Longitude: ${movementHistory[index].longitude}"),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("إغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // دالة لتحديد الموقع الحالي
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات الموقع غير مفعلة.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('تم رفض أذونات الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('تم رفض أذونات الموقع بشكل دائم.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // دالة لتحريك الكاميرا إلى الموقع الجديد
  Future<void> _goToTheNewPosition() async {
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lon), zoom: 15.0),
    ));
  }
}
