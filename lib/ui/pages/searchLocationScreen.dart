import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freshmarket/config/api/maps.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/get_location_provider.dart';
import 'package:freshmarket/providers/maps_page_provider.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/providers/store_provider.dart';
import 'package:freshmarket/ui/Widget/MarketItem/market_item.dart';
import 'package:freshmarket/ui/global/widget/skeleton.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

class SearchLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: Text('Lokasi Pengiriman ', style: headerTextStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: MapsBody(),
    );
  }
}

class MapsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// This is a function to initialize map view
    final mapProv = Provider.of<MapProvider>(context);
     final addressProv = Provider.of<AddressProvider>(context);
    final pageProv = Provider.of<PageProvider>(context, listen: false);
    if (mapProv.cameraPosition == null) {
      mapProv.initCamera(context);
    } else {
      //When map already loaded then show the item
      if (pageProv.bottomPosition == -200) {
        pageProv.updateBottomPosition(30);
      }
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Stack(
      children: <Widget>[
        MarkerItem.instance.myLocationMarker(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
        ),
        mapProv.cameraPosition != null
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  tiltGesturesEnabled: false,
                  onTap: (latLng) => mapProv.setMyLocation(latLng),
                  markers: mapProv.markers,
                  polylines: mapProv.polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: mapProv.cameraPosition!,
                  onMapCreated: mapProv.onMapCreated,
                  mapToolbarEnabled: false,
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),

        AnimatedPositioned(
          duration: Duration(seconds: 4),
          curve: Curves.elasticInOut,
          bottom: pageProv.bottomPosition,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(25),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  mapProv.tempAddress ?? 'Loading...',
                  style: headerTextStyle.copyWith(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    mapProv.setComplateAddress(mapProv.locationDetail, false);
                       addressProv.CheckCity(mapProv.locationDetail[0].subAdministrativeArea);
                    navigate.pop();
                  },
                  child: Text("Set lokasi",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    primary: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

        // mapProv.isNavigate == true
        //   ? NavigationItem() : SizedBox(),

        // mapProv.isNavigate == false ? ()
        //   : SizedBox(),
      ],
    );
  }

  Widget _BoxLocation() {
    return Stack(
      children: [],
    );
  }

  Widget _myLocationWidget() {
    return Builder(builder: (context) {
      return Consumer<MyLocationProvider>(
        builder: (context, mapProv, _) {
          return Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: InkWell(
                onTap: () =>
                    mapProv.changeCameraPosition(mapProv.sourceLocation!),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.orange,
                  ),
                ),
              ));
        },
      );
    });
  }
}
