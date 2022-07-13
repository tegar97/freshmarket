import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/ui/Widget/input_costume.dart';
import 'package:freshmarket/ui/global/widget/input.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib di isi'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib di isi'),
  ]);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);

    handleLogin() async {
      _formKey.currentState!.validate();
      if (await usersProvider.login(
          email: email!.text.toString(), password: password!.text.toString())) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Text(
                    "Masuk",
                    style: headerTextStyle.copyWith(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 39,
                          ),
                          CustomFormField(
                              hintText: 'Masukan email anda',
                              state: email!,
                              labelText: 'Email',
                              validator: emailValidator),
                          SizedBox(
                            height: 39,
                          ),
                          CustomFormField(
                              hintText: 'Masukan password',
                              state: password!,
                              labelText: 'Password',
                              isSecure: true,
                              validator: passwordValidator),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Lupa password ?",
                        style: secondaryText,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          handleLogin();
                        },
                        child: Text("Masuk",
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
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya akun ? ",
                            style: blackTextStyle.copyWith(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                "Daftar sekarang ",
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
