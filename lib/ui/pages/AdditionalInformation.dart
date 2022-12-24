import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freshmarket/models/addressModels.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/cart_providers.dart';
import 'package:freshmarket/providers/maps_provider.dart';
import 'package:freshmarket/ui/global/widget/input.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/checkoutScreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/ui/Widget/input_costume.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({Key? key}) : super(key: key);

  @override
  State<AdditionalInformation> createState() => _AdditionalInformation();
}

class _AdditionalInformation extends State<AdditionalInformation> {
  TextEditingController? label = TextEditingController(text: "");
  TextEditingController? phoneNumber = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    LocationPermission? permission;
    bool serviceEnabled;
    MapProvider mapProv = Provider.of<MapProvider>(context);

    submit() async {
      var data = AddressModels(
          label: label!.text.toString(),
          province: mapProv.locationDetail[0].administrativeArea,
          city: mapProv.locationDetail[0].subAdministrativeArea,
          districts: mapProv.locationDetail[0].subLocality,
          phoneNumber: phoneNumber!.text.toString(),
          isMainAddress: 1,
          street: mapProv.locationDetail[0].street,
          latitude: mapProv.sourceLocation?.latitude.toString(),
          longitude: mapProv.sourceLocation?.longitude.toString(),
          fullAddress: mapProv.complateAddress);

      if (label?.text != '' && phoneNumber?.text != '') {
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        await addressProvider.addAddress(token, data);
        await Provider.of<AddressProvider>(context, listen: false)
            .getSelectedAddress();
        await Provider.of<AddressProvider>(context, listen: false)
            .getListAddress();
        Timer(
            Duration(seconds: 1),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckOutScreen(
                          carts: cartProvider.carts,
                        ))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text(
              "Mohon , isi semua form yang tersedia",
              textAlign: TextAlign.center,
            )));
      }
    }

    return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: AppBar(
          title: Text("Buat Kontak baru",
              style: headerTextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          centerTitle: true,
          backgroundColor: lightModeBgColor,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            tooltip: 'Kembali ke page sebleumnya',
            onPressed: () {
              // handle the press
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi Pengiriman",
                    style: headerTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: neutral30,
                        )),
                    child: Text("${mapProv.complateAddress ?? "no data"}",
                        style: headerTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigate.pushTo('/search-location');
                    },
                    child: Text("Ganti Lokasi Pengiriman",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(width: 1, color: primaryColor),
                      primary: primaryColor,
                      minimumSize: Size(double.infinity, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Informasi tambahan ",
                    style: headerTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    hintText: 'Misal Rumah , Kantor , dll',
                    state: label!,
                    labelText: 'Label alamat',
                    validator:
                        RequiredValidator(errorText: 'Label wajib di isi'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    hintText: 'Nomor hp yang bisa di hubungi',
                    state: phoneNumber!,
                    labelText: 'Nomor hp',
                    validator: RequiredValidator(
                        errorText: 'phoneNumber   wajib di isi'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  addressProvider.onSearch == true
                      ? TextButton(
                          onPressed: () {
                            submit();
                          },
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: neutral20,
                            primary: Colors.white,
                            minimumSize: Size(double.infinity, 60),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(23)),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            submit();
                          },
                          child: Text("Tambahkan alamat",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700)),
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            primary: Colors.white,
                            minimumSize: Size(double.infinity, 60),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(23)),
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        )));
  }
}
