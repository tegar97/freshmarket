import 'package:flutter/material.dart';
import 'package:freshmarket/ui/global/widget/input.dart';
import 'package:freshmarket/ui/home/theme.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
    TextEditingController? label;
    TextEditingController? name;
    TextEditingController? province;
    TextEditingController? city;
    TextEditingController? districts;
    TextEditingController? phoneNumber;
    TextEditingController? complateAddress;

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          children: [
              InputField(
                labelText: "Label alamat",
                hintText: "Misal Rumah,Kantor , dll",
                stateName: label),
                 SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Nama",
                hintText: "Masukan nama penerima",
                stateName: label),
                  SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Provinsi",
                hintText: "Masukan provinsi anda tinggal",
                stateName: province),
                  SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Kota",
                hintText: "Masukan kota anda tinggal",
                stateName: city),
                  SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Kabupaten",
                hintText: "Masukan kabupaten anda tinggal",
                stateName: districts),
                       SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Nomor hp",
                hintText: "Masukan Nomor hp",
                stateName: phoneNumber),
                       SizedBox(
              height: 20,
            ),
              InputField(
                labelText: "Alamat lengkap",
                hintText: "masukan alamat lengkap",
                stateName: complateAddress),

            SizedBox(
              height: 40,
            ),
                TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              child: Text("Tambahkan alamat",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                primary: Colors.white,
                minimumSize: Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(23)),
                ),
              ),
            ),
               
          ],
        )));
  }
}
