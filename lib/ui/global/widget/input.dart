
import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final String type;
  final String hintText;
  final bool enable;
  final TextEditingController? stateName;
  const InputField(
      {required this.labelText,
      this.type = 'false',
      required this.hintText,
      required this.stateName,
      this.enable = true,
      Key? key})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText,
            style: labelTextStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w500)),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          enabled: widget.enable,
          style: TextStyle(fontSize: 14),
          obscureText: widget.type == 'password' ? true : false,
          controller: widget.stateName,
          keyboardType: widget.type == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          decoration: InputDecoration(
            fillColor: widget.enable == true ? neutral20 : Color(0xffEDEDED),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: neutral20, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: neutral20, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffEDEDED), width: 1.5),
            ),
            focusColor: Colors.red,
            labelStyle: TextStyle(color: primaryColor),
            hintText: widget.hintText,

            contentPadding: EdgeInsets.all(18), // Added this
          ),
        ),
      ],
    );
  }
}
