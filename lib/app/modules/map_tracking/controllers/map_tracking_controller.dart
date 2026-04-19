import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class StationStop {
  final String name;
  final String arrivalTime;
  final String departureTime;
  final String status; // 'visited', 'current', 'upcoming'

  StationStop({
    required this.name,
    required this.arrivalTime,
    required this.departureTime,
    this.status = 'upcoming',
  });
}

class MapTrackingController extends GetxController {
  late GoogleMapController mapController;

  final markers = <Marker>{}.obs;
  final polylines = <Polyline>{}.obs;
  final isPermissionGranted = false.obs;

  // Live Stats
  final speed = '60 kmph'.obs;
  final eta = '5:30 PM'.obs;
  final trainName = 'Padma Express'.obs;
  final trainNo = '#62367254'.obs;
  final prevStation = 'Kamalapur'.obs;
  final nextStation = 'Bhairab'.obs;

  // Timeline Data
  final timeline = <StationStop>[
    StationStop(name: 'Kamalapur', arrivalTime: '8:15 AM', departureTime: '8:20 AM', status: 'visited'),
    StationStop(name: 'Airport', arrivalTime: '8:45 AM', departureTime: '8:50 AM', status: 'current'),
    StationStop(name: 'Joydebpur', arrivalTime: '9:15 AM', departureTime: '9:20 AM', status: 'upcoming'),
    StationStop(name: 'Bhairab Bazar', arrivalTime: '10:30 AM', departureTime: '10:35 AM', status: 'upcoming'),
    StationStop(name: 'Mymensingh', arrivalTime: '12:00 PM', departureTime: '12:15 PM', status: 'upcoming'),
  ].obs;

  final LatLng startLocation = const LatLng(23.7276, 90.4106); // Kamalapur
  final LatLng endLocation = const LatLng(23.8517, 90.4003); // Dhaka Airport

  @override
  void onInit() {
    super.onInit();
    _initMapData();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;
    isPermissionGranted.value = true;
  }

  void _initMapData() {
    markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: startLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('current'),
        position: const LatLng(23.7937, 90.4066), 
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [
          startLocation,
          const LatLng(23.7937, 90.4066),
          endLocation,
        ],
        color: const Color(0xFF2C9E6A),
        width: 5,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        startLocation.latitude < endLocation.latitude ? startLocation.latitude : endLocation.latitude,
        startLocation.longitude < endLocation.longitude ? startLocation.longitude : endLocation.longitude,
      ),
      northeast: LatLng(
        startLocation.latitude > endLocation.latitude ? startLocation.latitude : endLocation.latitude,
        startLocation.longitude > endLocation.longitude ? startLocation.longitude : endLocation.longitude,
      ),
    );
    
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100)); // Padding to account for sheet
  }

  void shareLocation() {
    Get.snackbar(
      'Success',
      'Location shared successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C9E6A),
      colorText: Colors.white,
    );
  }
}
