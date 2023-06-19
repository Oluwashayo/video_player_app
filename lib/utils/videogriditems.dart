// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  String image;
  String title;
  String time;
  Function()? onTap;
  VideoInfo({
    Key? key,
    required this.image,
    required this.title,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 135,
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(
                        image,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        // color: color.AppColor
                        //     .homePageContainerTextBig,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Color(0xffeaeefc),
                      borderRadius: BorderRadius.circular(80)),
                  child: Center(
                    child: Text(
                      "15s rest",
                      style: TextStyle(
                        color: Color(0xff839fed),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < 60; i++)
                      Container(
                        height: 2,
                        width: 2,
                        margin: EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                          color: Color(0xff839fed),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
