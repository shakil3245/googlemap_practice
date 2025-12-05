import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../Controller/locationShowController.dart';


class MapScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.selectedLatLng.value,
                  zoom: 14.0,
                ),
                onTap: (latLng) {
                  controller.updateAddress(latLng);
                },
                markers: {
                  Marker(
                    markerId: MarkerId("selected"),
                    position: controller.selectedLatLng.value,
                  )
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            width: double.infinity,
            child: Obx(() => Text(
              "Selected Address:\n${controller.selectedAddress.value}",
              style: TextStyle(fontSize: 16),
            )),
          ),
        ],
      ),
    );
  }
}
