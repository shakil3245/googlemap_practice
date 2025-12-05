import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MarkerController extends GetxController {
  GoogleMapController? mapController;

  var markers = <Marker>{}.obs;

  // Default location that show when app open
  final CameraPosition initialCamera = const CameraPosition(
    target: LatLng(23.6850, 90.3563),
    zoom: 8,
  );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ---------------------------------------------------------
  // 1) Add Basic Marker
  // ---------------------------------------------------------
  void addBasicMarker() {
    markers.add(
      Marker(
        markerId: const MarkerId("basic"),
        position: const LatLng(23.6850, 90.3563),
        infoWindow: const InfoWindow(title: "Basic Marker"),
      ),
    );
  }

  // ---------------------------------------------------------
  // 2) Custom Local Asset Marker
  // ---------------------------------------------------------

  Future<BitmapDescriptor> customIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(80, 80)),
      'assets/images/marker.png', // your local asset
    );
  }

  Future<void> addCustomMarker() async {
    final icon = await customIcon();
    markers.add(
      Marker(
        markerId: const MarkerId("custom"),
        position: const LatLng(23.6850, 90.3563),
        icon: icon,
        infoWindow: const InfoWindow(title: "Custom Icon Marker"),
      ),
    );
  }


  // ---------------------------------------------------------
  // 3) Network Image Marker (BitmapDescriptor from URL)
  // ---------------------------------------------------------
  Future<BitmapDescriptor> networkIcon(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Uint8List bytes = response.bodyBytes;

    return BitmapDescriptor.fromBytes(bytes);
  }

  Future<void> addNetworkMarker() async {
    final icon = await networkIcon(
      "https://cdn-icons-png.flaticon.com/128/14090/14090489.png",
    );

    markers.add(
      Marker(
        markerId: const MarkerId("network"),
        position: const LatLng(23.6850, 90.3563),
        icon: icon,
        infoWindow: const InfoWindow(title: "Network Image Marker"),
      ),
    );
  }

  // ---------------------------------------------------------
  // 4) Animate Camera to Marker
  // ---------------------------------------------------------
  Future<void> animateTo(LatLng position) async {
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15),
      ),
    );
  }
}
