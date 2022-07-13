import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/images/information_banner1.jpg',
  'assets/images/information_banner1.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
      margin: EdgeInsets.only(right: 16),
          child: Container(
            width: double.infinity,
            height: 158,

            child: ClipRRect(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      fit: BoxFit.fill,
                      width: double.infinity  ,
                      height: 158,
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class CaraouselBanner extends StatefulWidget {
  const CaraouselBanner({Key? key}) : super(key: key);

  @override
  State<CaraouselBanner> createState() => _CaraouselBannerState();
}

class _CaraouselBannerState extends State<CaraouselBanner> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                   aspectRatio: 2,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 0.95,  

                autoPlay: true,
                autoPlayInterval: Duration(milliseconds: 5000),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
