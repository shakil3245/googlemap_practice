import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {

  var selectedAddress = ''.obs;
  var selectedLatLng = LatLng(23.6850, 90.3563).obs;
  // default location

  Future<void> updateAddress(LatLng latLng) async {
    selectedLatLng.value = latLng;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        selectedAddress.value =
        "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      selectedAddress.value = "Error fetching address";
    }
  }
}
