import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshmarket/bloc/loading.dart';
import 'package:freshmarket/providers/auth_providers.dart';
import 'package:freshmarket/ui/Widget/input_costume.dart';
import 'package:freshmarket/ui/Widget/loading_button.dart';
import 'package:freshmarket/ui/global/widget/input.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';
import 'package:freshmarket/validator/input.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? name = TextEditingController(text: "");
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");
  Loading loadingBloc = Loading();

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib di isi'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib di isi'),
    MinLengthValidator(8, errorText: 'Panjang password minimal 8 karakter'),
  ]);

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    final _formKey = GlobalKey<FormState>();


    handleSignup() async {
      Loading().toTrue();
      _formKey.currentState!.validate();
      if (await usersProvider.register(
          name: name!.text.toString(),
          email: email!.text.toString(),
          password: password!.text.toString())) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red[500],
            content: Text(
              "Gagal register",
              textAlign: TextAlign.center,
            )));
      }
      Loading().toFalse();
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Text(
                    "Daftar",
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
                          CustomFormField(
                              hintText: 'Masukan nama anda',
                              labelText: 'Nama',
                              state: name!,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"),
                                )
                              ],
                              validator: RequiredValidator(
                                  errorText: "Nama Wajib di isi")),
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
                  SizedBox(
                    height: 10,
                  ),
                 
                  SizedBox(
                    height: 39,
                  ),
                  BlocBuilder<Loading, bool>(
                    bloc: loadingBloc,
                    builder: (context, state) {
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              handleSignup();
                            },
                            child: Text("Login",
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
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Udah punya akun ? ",
                            style: blackTextStyle.copyWith(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              "Login sekarang ",
                              style: primaryTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
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
