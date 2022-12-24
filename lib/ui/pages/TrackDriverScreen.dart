import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrackDriver(),
    );
  }
}

class TrackDriver extends StatefulWidget {
  @override
  _TrackDriver createState() => _TrackDriver();
}

class _TrackDriver extends State<TrackDriver> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(-6.939901, 107.739570);
  final LatLng _customerLocation = const LatLng(-6.939901, 107.739570);
  final LatLng _driverLocation = const LatLng(-6.937153, 107.730551);
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('customer'),
      position: _customerLocation,

      infoWindow: InfoWindow(title: 'Lokasi Pelanggan'),
    ));
    _markers.add(Marker(
      markerId: MarkerId('driver'),
      position: _driverLocation,
      infoWindow: InfoWindow(title: 'Lokasi Driver'),
    ));
    polylineCoordinates.add(_customerLocation);
    polylineCoordinates.add(_driverLocation);
    _polylines.add(Polyline(
        polylineId: PolylineId('polyline'),
        points: polylineCoordinates,
        color: primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
Future<Uint8List> getUint8List(GlobalKey widgetKey) async {
  RenderRepaintBoundary boundary =
      widgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage(pixelRatio: 2.0);
  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
