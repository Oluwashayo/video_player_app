import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/pages/videoPage.dart';
import '../colors.dart' as color;
import '../utils/griditems.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((value) => setState(() {
              info = List<Map<String, dynamic>>.from(json.decode(value));
            }));
  }

  // can also be rewritten like

  // _initData() async {
  //   final String data =
  //       await DefaultAssetBundle.of(context).loadString("json/info.json");
  //   setState(() {
  //     info = List<Map<String, dynamic>>.from(json.decode(data));
  //     // or info = json.decode(data);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    List text = ["Glutes", "Abs", "Legs", "Arms"];
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Training",
                    style: TextStyle(
                        color: color.AppColor.homePageTitle,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 20),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: color.AppColor.homePageIcons,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: color.AppColor.homePageIcons,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Your Program",
                    style: TextStyle(
                      color: color.AppColor.homePageSubtitle,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () => Get.to(() => VideoPage()),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        color: color.AppColor.homePageDetail,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Get.to(() => VideoPage()),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: color.AppColor.homePageIcons,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.AppColor.gradientFirst.withOpacity(0.8),
                      color.AppColor.gradientSecond.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(80),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20,
                      color: color.AppColor.gradientSecond.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Workout",
                        style: TextStyle(
                          color: color.AppColor.homePageContainerTextSmall,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Leg Toning\n"),
                            TextSpan(text: "and Glutes Workout"),
                          ],
                          style: TextStyle(
                            color: color.AppColor.homePageContainerTextBig,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 20,
                            color: color.AppColor.homePageContainerTextSmall,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "60 min",
                            style: TextStyle(
                              color: color.AppColor.homePageContainerTextSmall,
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: color.AppColor.gradientFirst,
                                  offset: Offset(4, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.play_circle_fill,
                              color: color.AppColor.homePageContainerTextSmall,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 180,
                // color: Colors.red,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 40,
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.3),
                          ),
                          BoxShadow(
                            offset: Offset(-4, -4),
                            blurRadius: 40,
                            color:
                                color.AppColor.gradientSecond.withOpacity(0.3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/card.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                        right: 180,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        // color: Colors.red.withOpacity(0.2),
                        image: DecorationImage(
                          image: AssetImage("assets/figure.png"),
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 150, top: 50),
                      // color: Colors.red.withOpacity(0.2),
                      height: 100,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You are doing Great",
                            style: TextStyle(
                              color: color.AppColor.homePageDetail,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: color.AppColor.homePagePlanColor,
                                  fontSize: 17),
                              children: [
                                TextSpan(text: 'Keep it up\n'),
                                TextSpan(text: 'stick to your plan'),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Area of focus",
                style: TextStyle(
                  color: color.AppColor.homePageTitle,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: info.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GridItems(
                      image: info[index]["img"],
                      text: info[index]['title'].toString(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
