import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white))
      ),
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        primary: Colors.white,
        minimumSize: Size(double.infinity, 60),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(23)),
        ),
      ),
    );
  }
}
