import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/MarkerController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenUI extends StatelessWidget {
  final MarkerController c = Get.put(MarkerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map Markers Demo")),
      body: Obx(
            () => GoogleMap(
          initialCameraPosition: c.initialCamera,
          onMapCreated: c.onMapCreated,
          markers: c.markers.value,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            label: const Text("Basic Marker"),
            onPressed: c.addBasicMarker,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            label: const Text("Custom Icon"),
            onPressed: c.addCustomMarker,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            label: const Text("Network Icon"),
            onPressed: c.addNetworkMarker,
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            label: const Text("Go to Network Marker"),
            onPressed: () => c.animateTo(const LatLng(23.8611, 90.0004)),
          ),
        ],
      ),
    );
  }
}
