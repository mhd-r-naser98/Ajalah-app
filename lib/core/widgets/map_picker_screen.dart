// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/widgets/app_snack_bar.dart';

class MapPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const MapPickerScreen({super.key, required this.initialPosition});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late MapController mapController;
  LatLng? pickedPosition;

  @override
  void initState() {
    super.initState();
    pickedPosition = widget.initialPosition;
    mapController = MapController();
  }

  void _onMapTap(TapPosition tapPosition, LatLng? latlng) {
    if (latlng == null) return;
    setState(() {
      pickedPosition = latlng;
    });
  }

  void _onConfirm() {
    if (pickedPosition != null) {
      Navigator.pop(context, pickedPosition);
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppSnackBar.error(context, 'يرجى تفعيل خدمة الموقع');

      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppSnackBar.error(context, 'تم رفض صلاحية الموقع');

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppSnackBar.error(
        context,
        'تم رفض صلاحية الموقع نهائياً، الرجاء تغيير الإعدادات',
      );

      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      pickedPosition = LatLng(position.latitude, position.longitude);
      mapController.move(pickedPosition!, 13);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر الموقع على الخريطة"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Select my Location',
            onPressed: _determinePosition,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save',
            onPressed: _onConfirm,
          ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.initialPosition,
          initialZoom: 13.0,
          onTap: _onMapTap,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          if (pickedPosition != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: pickedPosition!,
                  child: Icon(
                    Icons.location_on,
                    color: context.colors.primary.main,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
