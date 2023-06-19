// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../colors.dart' as color;

class GridItems extends StatelessWidget {
  String image;
  var text;
  GridItems({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              text,
              style: TextStyle(
                color: color.AppColor.homePageDetail,
                fontSize: 18,
              ),
            ),
          ),
        ),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color.AppColor.homePageBackground,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 3,
              color: color.AppColor.gradientSecond.withOpacity(0.1),
            ),
            BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 40,
              color: color.AppColor.gradientSecond.withOpacity(0.1),
            ),
          ],
        ),
      ),
    );
  }
}
