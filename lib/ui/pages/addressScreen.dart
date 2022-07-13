import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
        appBar: AppBar(
        title: Text("Alamat",
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
          tooltip: 'Kembali ke halaman product',
          onPressed: () {
            // handle the press
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          margin: EdgeInsets.only(bottom: 20),
          child:
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/courier.png'),
                  SizedBox(height: 60,),
                  Text("Yuk tambahin alamat",style: headerTextStyle.copyWith(fontSize: 24,fontWeight: FontWeight.w600)),
                  SizedBox(height: 10,),
                  Text("Biar kurir cepat sampai kerumah mu ,pastikan alamat sudah benar dan pastikan juga nomor hp aktif ",textAlign: TextAlign.center,style: subtitleTextStyle.copyWith(fontSize: 14,height: 1.4),),
                                    SizedBox(
                    height: 40,
                  ),

                    TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-address');
                    },
                    child: Text("Tambahkan alamat ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
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
              ),
            )
          
        ),
      ),
    );
  }
}
