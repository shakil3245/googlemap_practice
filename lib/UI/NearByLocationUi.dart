import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Controller/MapGestures_User_Interactions.dart';


class MapGestureScreen extends StatelessWidget {
  final MapGesturesUserInteractionsController controller = Get.put(MapGesturesUserInteractionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map with GetX'),
        actions: [
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: controller.changeMapType,
          ),
        ],
      ),
      body: Obx(
            () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194), // Example: San Francisco
            zoom: 12,
          ),
          onMapCreated: controller.onMapCreated,
          mapType: controller.mapType.value,
          markers: controller.markers,
          onTap: controller.onTap,
          onLongPress: controller.onLongPress,
        ),
      ),
    );
  }
}
