import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshmarket/providers/address_providers.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:freshmarket/ui/pages/addAddressScareen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsersProvider userProvider = Provider.of<UsersProvider>(context);

    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/avatar.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("${userProvider.users.name}",
                    textAlign: TextAlign.center,
                    style: headerTextStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 5,
                ),
                Text("${userProvider.users.email}",
                    textAlign: TextAlign.center,
                    style: subtitleTextStyle.copyWith(
                      fontSize: 14,
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Account",
              style: headerTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text("Edit Profile",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: Text("Pesanan saya",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text("Help",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "General",
              style: headerTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text("Privacy and policy",
                            style: headerTextStyle.copyWith(fontSize: 15))),
                    Icon(Icons.arrow_right_rounded, size: 30),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
        
                  // AddressProvider.instance(context).clearAddress();
                    localStorage.remove('user');
                    localStorage.remove('token');

                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("Keluar",
                              style: headerTextStyle.copyWith(fontSize: 15))),
                      Icon(Icons.arrow_right_rounded, size: 30),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
