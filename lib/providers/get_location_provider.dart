import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:freshmarket/config/api/maps.dart';
import 'package:freshmarket/models/outletModels.dart';
import 'package:freshmarket/service/outlet_dummy_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyLocationProvider extends ChangeNotifier {
  //------------------------//
  //   PROPERTY SECTIONS    //
  //------------------------//

  //Property zoom camera
  double _cameraZoom = 16;
  double get cameraZoom => _cameraZoom;

  //Property camera position
  CameraPosition? _cameraPosition;
  CameraPosition? get cameraPosition => _cameraPosition;

  //Property camera tilt
  double _cameraTilt = 0;
  double get cameraTilt => _cameraTilt;

  //Property camera bearing
  double _cameraBearing = 30;
  double get cameraBearing => _cameraBearing;

  //Property my location data
  LatLng? _sourceLocation;
  LatLng? get sourceLocation => _sourceLocation;

  //Property tubles list
  List<OutletModel> _outletList = ListOutlet.getOutlet();
  List<OutletModel> get outletList => _outletList;

  //Property tubles item filter
  //this variable will use when you activate
  //the search features
  List<OutletModel>? _filteredTubles;
  List<OutletModel>? get filteredTubles => _filteredTubles;

  //Property Google Map Controller completer
  Completer<GoogleMapController> _completer = Completer();
  Completer<GoogleMapController> get completer => _completer;

  //Property Google Map Controller
  GoogleMapController? _controller;
  GoogleMapController? get controller => _controller;

  //Property to save all markers
  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  //Property to save all polylines
  Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  //Property to save all direction coordinate routes
  List<LatLng> _polylineCoordinates = [];
  List<LatLng> get polylineCoordinates => _polylineCoordinates;

  // which generates every polyline between start and finish
  GoogleMapPolyline? _polylinePoints;
  GoogleMapPolyline? get polylinePoints => _polylinePoints;

  //Your google maps API
  //Please enable this API Features:
  //- Google Maps for Android SDK
  //- Place API
  //- Directions API
  String _googleAPIKey = "<YOUR API KEY>";
  String get apiKey => _googleAPIKey;

  //Property to handle selected tubles
  OutletModel? _outletListSelected;
  OutletModel? get outletListSelected => _outletListSelected;

  //Property to handle if the users navigate to tubles or not
  bool _isNavigate = false;
  bool get isNavigate => _isNavigate;

  //Property to mapStyle
  String? _mapStyle;
  String? get mapStyle => _mapStyle;

  //Property polylines color
  Color _polyLineColor = Colors.amber;

  //Property location services
  Position? location;
  StreamSubscription<Position>? locationSubscription;

  //Property to save buildcontext
  BuildContext? _context;
  BuildContext? get context => _context;

  ///Custom key for custom marker
  final markerKey = GlobalKey();
  final myLocationKey = GlobalKey();

  /// Property to save distance in navigate mode
  String _distance = "0 meter";
  String get distance => _distance;

  //------------------------//
  //   FUNCTION SECTIONS   //
  //------------------------//

  //Function to initialize camera
  void initCamera(BuildContext context) async {
    //Get current locations
    await initLocation();

    //Set current location to camera
    _cameraPosition = CameraPosition(
        zoom: cameraZoom,
        bearing: cameraBearing,
        tilt: cameraTilt,
        target: sourceLocation!);

    //Set context
    _context = context;
    notifyListeners();
  }

  //Function to get current locations
  Future<void> initLocation() async {
    LocationPermission permission;
    Position? currentPos;

    if (await Geolocator.isLocationServiceEnabled()) {
      permission = await Geolocator.checkPermission();
      if ((permission != LocationPermission.always ||
          permission != LocationPermission.whileInUse)) {
        permission = await Geolocator.requestPermission();
        currentPos = Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0);
      }

      try {
        currentPos = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            timeLimit: Duration(seconds: 10));
      } catch (e) {
        currentPos = await Geolocator.getLastKnownPosition();
      }
    } else {
      currentPos = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    }
    _sourceLocation = LatLng(currentPos!.latitude, currentPos.longitude);
    notifyListeners();
  }

  //Function to listening user location changed
  void listeningLocation() {
    //Adding location listener
    Geolocator.getPositionStream().listen((data) {
      var locData = LatLng(data.latitude, data.longitude);

      /// Set current location
      setMyLocation(locData);

      /// Get distance
      getDistance(locData);
    });
  }

  //Function to stop listening location changed
  void stopListeningLocation() {
    locationSubscription?.cancel();
  }

  /// Function to set current location
  void setMyLocation(LatLng loc) {
    _sourceLocation = loc;
    print(loc.latitude.toString());

    updateMyLocationMaker(true, false);
    notifyListeners();
  }

  /// Function to get distance between two locations
  void getDistance(LatLng myLocation) async {
    _distance =
        await calculateDistance(myLocation, outletListSelected!.location!);
    notifyListeners();
  }

  //Function to change camera position
  void changeCameraPosition(LatLng location,
      {bool useBearing = false, bool customZoom = false}) {
    // _controller.animateCamera(CameraUpdate.newLatLngZoom(
    //   LatLng(location.latitude, location.longitude), cameraZoom));
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(location.latitude, location.longitude),
        bearing: useBearing == true ? cameraBearing : 0,
        zoom: customZoom == true ? 18 : cameraZoom)));

    notifyListeners();
  }

  //Function to handle when maps created
  void onMapCreated(GoogleMapController controller) async {
    //Loading map style
    _mapStyle = await rootBundle.loadString(Config.mapStyleFile);

    _controller = controller;

    //Set style to map
    // _controller!.setMapStyle(_mapStyle!);

    setMapPins(sourceLocation, outletList);

    notifyListeners();
  }

  //Function to set marker into my locations
  void setMyLocationMarker() async {
    ///Create marker point
    Uint8List markerIcon = await getUint8List(myLocationKey);
    notifyListeners();

    _markers.add(Marker(
        markerId: MarkerId("sourcePin"),
        position: sourceLocation!,
        icon: BitmapDescriptor.fromBytes(markerIcon)));

    notifyListeners();
  }

  //Function to set marker into my locations
  void updateMyLocationMaker(bool customZoom, bool useBearing) async {
    //Change camera position
    if (_controller != null) {
      changeCameraPosition(sourceLocation!,
          customZoom: customZoom, useBearing: useBearing);
    }

    //Remove current marker
    _markers.removeWhere((m) => m.markerId.value == "sourcePin");

    ///Create marker point
    Uint8List markerIcon = await getUint8List(myLocationKey);
    notifyListeners();
    //Adding new marker
    _markers.add(Marker(
        markerId: MarkerId("sourcePin"),
        position: sourceLocation!,
        icon: BitmapDescriptor.fromBytes(markerIcon)));

    notifyListeners();
  }

  //Function to pin my location and tubles list
  void setMapPins(
      LatLng? sourceLocation, List<OutletModel> destinationList) async {
    //Set my location marker
    setMyLocationMarker();

    for (int i = 0; i < destinationList.length; i++) {
      var data = destinationList[i];

      _outletListSelected = data;
      await Future.delayed(Duration(milliseconds: 100));

      ///Create marker point
      Uint8List markerIcon = await getUint8List(markerKey);
      notifyListeners();

      _markers.add(Marker(
          markerId: MarkerId(data.title!),
          position: data.location!,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () => setSelected(data)));
    }

    notifyListeners();
  }

  /// Function to search tubles location by keyword
  void searchTubles(String keyword) async {
    /// Filter search by title
    if (keyword.length > 0) {
      _filteredTubles = outletList
          .where((element) =>
              element.title!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    } else {
      _filteredTubles = null;
    }
    notifyListeners();
  }

  /// Function to handle search click event
  void onItemSearchClick(OutletModel tubles) async {
    /// Set filtered to null
    _filteredTubles = null;
    notifyListeners();

    /// Set selected tubles
    changeCameraPosition(sourceLocation!, customZoom: true);
    await setSelected(tubles, fromSearch: true);

    navigate();
  }

  //Function to set selected tubles
  Future<void> setSelected(OutletModel data, {bool fromSearch = false}) async {
    _outletListSelected = data;

    //Remove previous polylines
    clearPolylines();

    if (fromSearch == false) {
      //Set polyline ketika klik marker
      await setPolyLines(data.location!);
    }

    if (fromSearch == false) {
      /// Change Pageview position
      int index = outletList.indexOf(data);
      // Provider.of<PageProvider>(context!, listen: false).navigatePageTo(index);
    }

    notifyListeners();
  }

  //Function to create a polylines into maps
  Future<void> setPolyLines(LatLng destination) async {
    List<LatLng>? result;
    try {
      _polylinePoints = GoogleMapPolyline(apiKey: apiKey);
      result = await _polylinePoints!.getCoordinatesWithLocation(
          origin: sourceLocation!,
          destination: destination,
          mode: RouteMode.driving);
    } on Exception catch (e) {
      print("ERROR GAN: " + e.toString());
    }

    if (result != null && result.isNotEmpty) {
      result.forEach((LatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("GAGAL DAPET POLYLINE");
    }

    Polyline poly = Polyline(
        polylineId: PolylineId("Polylines"),
        color: _polyLineColor,
        points: _polylineCoordinates,
        width: 5);

    _polylines.add(poly);
    notifyListeners();
  }

  //Function to clear all polylines
  void clearPolylines() {
    _polylines.clear();
    _polylineCoordinates.clear();
    notifyListeners();
  }

  //Function to navigate into tubles destination
  void navigate({OutletModel? tubles}) async {
    if (tubles != null) {
      await setSelected(tubles);
    }

    //Removing previous marker and polylines
    _markers.clear();
    clearPolylines();

    // _tublesSelected = await tubles;
    await Future.delayed(Duration(milliseconds: 100));

    ///Create marker point
    Uint8List markerIcon = await getUint8List(markerKey);
    notifyListeners();

    //Adding new marker destination
    _markers.add(Marker(
      markerId: MarkerId(outletListSelected!.title!),
      position: outletListSelected!.location!,
      icon: BitmapDescriptor.fromBytes(markerIcon),
    ));

    //Set my location marker
    setMyLocationMarker();

    //Set polylines to marker
    setPolyLines(outletListSelected!.location!);

    //set navigate status
    _isNavigate = true;

    /// Get Distance between two locations
    getDistance(sourceLocation!);

    //Enable location listener
    listeningLocation();

    notifyListeners();
  }

  //Function to stop navigation
  void stopNavigate() {
    _isNavigate = false;
    _markers.clear();
    clearPolylines();

    setMapPins(sourceLocation, outletList);

    //Stop listening location
    stopListeningLocation();

    /// Reset page item
    // Provider.of<PageProvider>(context!, listen: false).resetPageView();

    /// Reinitialize locations
    initLocation();
    updateMyLocationMaker(false, true);

    notifyListeners();
  }

  /// Converting Widget to PNG
  Future<Uint8List> getUint8List(GlobalKey widgetKey) async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// Calculate distance between two location
  Future<String> calculateDistance(
      LatLng firstLocation, LatLng secondLocation) async {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((secondLocation.latitude - firstLocation.latitude) * p) / 2 +
        c(firstLocation.latitude * p) *
            c(secondLocation.latitude * p) *
            (1 - c((secondLocation.longitude - firstLocation.longitude) * p)) /
            2;
    var distance = 12742 * asin(sqrt(a));

    if (distance < 1) {
      return (double.parse(distance.toStringAsFixed(3)) * 1000)
              .toString()
              .split(".")[0] +
          " meter";
    } else {
      return double.parse(distance.toStringAsFixed(2)).toString() + " km";
    }
  }
}
