import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/ui/global/widget/input.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/ui/Widget/input_costume.dart';
import 'package:geolocator/geolocator.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController? label = TextEditingController(text: "");
  TextEditingController? name = TextEditingController(text: "");
  TextEditingController? province = TextEditingController(text: "");
  TextEditingController? city = TextEditingController(text: "");
  TextEditingController? districts = TextEditingController(text: "");
  TextEditingController? phoneNumber = TextEditingController(text: "");
  TextEditingController? complateAddress = TextEditingController(text: "");
  TextEditingController? street = TextEditingController(text: "");
  String? latitude;
  String? longitude;
  bool? isMainAddress = false;
  List<Placemark>? placemarks;
  LocationPermission? locationPermission;

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    LocationPermission? permission;
    bool serviceEnabled;
    Future<Position> _determinePosition() async {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      print(permission);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            locationPermission = LocationPermission.denied;
          });
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        setState(() {
          locationPermission = LocationPermission.deniedForever;
        });
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        locationPermission = LocationPermission.whileInUse;
      });
      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      print(position);
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);

      province!.value =
          province!.value.copyWith(text: placemarks![0].administrativeArea);
      street!.value = province!.value.copyWith(text: placemarks![1].street);
      city!.value =
          city!.value.copyWith(text: placemarks![0].subAdministrativeArea);
      districts!.value =
          districts!.value.copyWith(text: placemarks![0].subLocality);
      complateAddress!.value = complateAddress!.value.copyWith(
          text: placemarks![1].street! +
              " , " +
              placemarks![1].locality! +
              " , " +
              placemarks![1].subLocality! +
              " , " +
              placemarks![1].subAdministrativeArea! +
              " , " +
              placemarks![1].administrativeArea! +
              placemarks![1].postalCode!);

      return await Geolocator.getCurrentPosition();
    }

    handleAddAddress() async {
      if (await addressProvider.addAddress(
          label: label!.text.toString(),
          province: province!.text.toString(),
          city: city!.text.toString(),
          districts: districts!.text.toString(),
          phoneNumber: phoneNumber!.text.toString(),
          isMainAddress: isMainAddress,
          street: street!.text.toString(),
          latitude: latitude,
          longitude: longitude,
          fullAddress: complateAddress!.text.toString())) {
        Navigator.pushReplacementNamed(context, '/address');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text(
              "Email atau password salah",
              textAlign: TextAlign.center,
            )));
      }
    }

    return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: AppBar(
          title: Text("Tambah alamat baru",
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
            child: locationPermission == LocationPermission.whileInUse
                ? ListView(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    children: [
                      Form(
                        child: Column(
                          children: [
                            CustomFormField(
                              hintText: 'Misal Rumah , Kantor , dll',
                              state: label!,
                              labelText: 'Label alamat',
                              validator: RequiredValidator(
                                  errorText: 'Label wajib di isi'),
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
                            CustomFormField(
                              hintText: 'Masukan provinsi anda tinggal',
                              state: province!,
                              labelText: 'Provinsi',
                              validator: RequiredValidator(
                                  errorText: 'Provinsi   wajib di isi'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomFormField(
                              hintText: 'Masukan Kota anda tinggal',
                              state: city!,
                              labelText: 'Kota ',
                              validator: RequiredValidator(
                                  errorText: 'Kota wajib di isi'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomFormField(
                              hintText: "Kecamatan",
                              state: districts!,
                              labelText: 'Kecamatan',
                              validator: RequiredValidator(
                                  errorText: 'Kecamatan wajib di isi'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomFormField(
                              hintText: "Alamat lengkap",
                              state: complateAddress!,
                              maxLines: 3,
                              labelText: 'Alamat',
                              validator: RequiredValidator(
                                  errorText: 'Alamat lengkap wajib di isi'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: EdgeInsets.all(0),
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                    ),
                                    // here toggle the bool value so that when you click
                                    // on the whole item, it will reflect changes in Checkbox
                                    onPressed: () => setState(
                                        () => isMainAddress = !isMainAddress!),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 24.0,
                                              child: Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor: primaryColor,
                                                  value: isMainAddress,
                                                  onChanged: (value) {
                                                    setState(() =>
                                                        isMainAddress = value);
                                                  })),
                                          // You can play with the width to adjust your
                                          // desired spacing
                                          Text("Jadikan alamat utama",
                                              style: headerTextStyle.copyWith(
                                                  color: Colors.black))
                                        ]))),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                handleAddAddress();
                              },
                              child: Text("Tambahkan alamat",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
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
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/supply.png',height: 250,),
                        SizedBox(
                          height: 60,
                        ),
                        Text("Izin Lokasi",
                            style: headerTextStyle.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Agar pengiriman lebih akurat izinkan kami mengakses lokasi terkini anda ",
                          textAlign: TextAlign.center,
                          style: subtitleTextStyle.copyWith(
                              fontSize: 14, height: 1.4),
                        ),
                        SizedBox(height: 20,),

                        TextButton(
                          onPressed: () {
                            _determinePosition();
                          },
                          child: Text("Gunakan Lokasi saya terkini ",
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
                    )),
                  )));
  }
}
