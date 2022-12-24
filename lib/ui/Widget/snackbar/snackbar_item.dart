import 'package:flutter/material.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/ui/home/theme.dart';


_getSnackbar({
  String? title,
  Widget? icon,
  Color? color,
  bool floating = false,
  bool isError = false,
}) {

  return SnackBar(
    duration: Duration(seconds: isError ? 3 : 2),
    behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    margin: floating ? EdgeInsets.only(bottom: 50) : null,
    content: Row(
      children: [
        icon ?? const SizedBox(),
        icon != null ? const SizedBox(width: 10) : const SizedBox(),
        Expanded(
          child: Text(
            title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: headerTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: color ?? primaryColor,
  );
}

showSnackbar({
  required String? title,
  Icon? icon,
  Color? color,
  bool floating = false,
  bool isError = false,
}) =>
    ScaffoldMessenger.of(
      navigate.navigatorKey.currentContext!,
    ).showSnackBar(
      
      _getSnackbar(
        title: title,
        icon: icon,
        color: color,
        floating: floating,
        isError: isError,
      ),
    );
