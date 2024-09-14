//بدنا هون خريطة بتعرض موقع الطفل على الخريطة بحيث تكون
//موافقة للون التطبيق العام وما ننسىفكرة الستايل الموحد
//فيكي تعملي رن لشغلك ومن ثم ترجعي صفحة تسجيل الدخول هيي بتابع المين
//بدنا هون خريطة بتعرض موقع الطفل على الخريطة بحيث تكون
//موافقة للون التطبيق العام وما ننسىفكرة الستايل الموحد
//فيك تعمل رن لشغلك ومن ثم ترجع صفحة تسجيل الدخول هيي بتابع المين
// ما تنسى تخزن الموقع الحالي بمتحول بحيث اذا بدك تبعت الموقع لك تلاتين ثانية جهز
//انت بحيث اذا طلع الموقع من التطبيق ترفع م ن هون مباشرة
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  final LatLng _safetyZone = const LatLng(34.8722117, 35.8921997);
  // LatLng(34.8722117, 35.8921997)

  final double _radius = 1000.0;
  bool loading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    loading = true;
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        log('Current Location: $_currentPosition');

        // التحقق مما إذا كنت خارج المنطقة الآمنة
        if (_currentPosition != null) {
          bool isWithinZone = _isWithinSafetyZone(_currentPosition!);
          if (!isWithinZone) {
            log('لقد اجتزت المنطقة الآمنة!');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('أنت خارج المنطقة الآمنة!')),
            );
          } else {
            log('أنت داخل المنطقة الآمنة.');
          }
        }
      });
    } catch (e) {
      log('Error getting location: $e');
    }
  }

  bool _isWithinSafetyZone(LatLng currentLocation) {
    double distanceInMeters = Geolocator.distanceBetween(
      _safetyZone.latitude,
      _safetyZone.longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    );
    return distanceInMeters <= _radius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlueAccent,
        title: const Center(child: Text('Location Child')),
      ),
      body:  !loading? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: {
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: 'your child location'),
          ),

        },
        circles: {
          Circle(
            circleId: const CircleId('safetyZoneCircle'),
            center: _safetyZone,
            radius: _radius,
            fillColor: Colors.lightBlueAccent.withOpacity(0.3),
            strokeColor: Colors.lightBlueAccent,
            strokeWidth: 2,
          ),
        },
      ),
    );
  }
}


