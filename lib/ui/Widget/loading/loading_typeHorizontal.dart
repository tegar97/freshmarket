import 'package:flutter/material.dart';
import 'package:freshmarket/ui/home/theme.dart';

class LoadingTypeHorizontal extends StatelessWidget {
  final int length;

  const LoadingTypeHorizontal({
    Key? key,
    this.length = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double widthDevice = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            length,
            (i) => Container(
              width: widthDevice * 0.30,
              height: 114,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: neutral70.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
