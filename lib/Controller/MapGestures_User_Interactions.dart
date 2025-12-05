import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGesturesUserInteractionsController extends GetxController {
  // Map controller
  GoogleMapController? mapController;

  // Current markers
  var markers = <Marker>{}.obs;

  // Map type
  var mapType = MapType.satellite.obs;

  // Next marker id counter
  int _markerIdCounter = 1;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onTap(LatLng position) {
    print('Map tapped at: $position');
  }

  void onLongPress(LatLng position) {
    final markerId = MarkerId('marker_$_markerIdCounter');
    _markerIdCounter++;

    final marker = Marker(
      markerId: markerId,
      position: position,
      draggable: true,
      onDragEnd: (newPosition) {
        print('Marker $markerId moved to $newPosition');
      },
    );

    markers.add(marker);
  }

  void changeMapType() {
    if (mapType.value == MapType.normal) {
      mapType.value = MapType.terrain;
    } else if (mapType.value == MapType.terrain) {
      mapType.value = MapType.hybrid;
    } else {
      mapType.value = MapType.normal;
    }
  }
}
