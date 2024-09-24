//بدنا هون خريطة بتعرض موقع الطفل على الخريطة بحيث تكون
//موافقة للون التطبيق العام وما ننسىفكرة الستايل الموحد
//فيك تعمل رن لشغلك ومن ثم ترجع صفحة تسجيل الدخول هيي بتابع المين
// ما تنسى تخزن الموقع الحالي بمتحول بحيث اذا بدك تبعت الموقع لك تلاتين ثانية جهز
//انت بحيث اذا طلع الموقع من التطبيق ترفع م ن هون مباشرة
import 'dart:async';

import 'package:child_barcelet/component/Color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  late Position currentPosition;
  Set<Marker> markers = {};
  bool isloading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      currentPosition = value;
      _updateMarkers();

      // Start the periodic location updates
      _timer = Timer.periodic(Duration(seconds: 30), (timer) {
        _determinePosition().then((newPosition) {
          currentPosition = newPosition;
          _updateMarkers();
        });
      });

      setState(() {
        isloading = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _updateMarkers() {
    markers.clear();
    markers.add(
      Marker(
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: 'My current location',
          onTap: () {
            print("#########:    ${currentPosition}");
          },
        ),
        markerId: MarkerId("currentLocation"),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
      ),
    );
    setState(() {}); // Update the UI with the new markers
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController? gmc;
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع الموقع الطفل"),
        backgroundColor: globalcolor,
      ),
      body: Container(
        child: isloading
            ? GoogleMap(
                markers: markers.toSet(),
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentPosition.latitude, currentPosition.longitude),
                  zoom: 14,
                  tilt: 59.44,
                ),
                onMapCreated: (GoogleMapController c) async {
                  gmc = c;

                  markers.add(
                    Marker(
                      markerId: MarkerId("currentLocation"),
                      position: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                    ),
                  );
                  print("#########position=   " + currentPosition.toString());
                  gmc!.moveCamera(CameraUpdate.newLatLngZoom(
                      LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      14));
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition();
    print("@@@@@@@@   ${currentPosition}");

    //updateMarkers();
    return currentPosition;
  }
}
