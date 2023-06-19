import 'dart:convert';
import 'dart:math';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/utils/videogriditems.dart';
import '../colors.dart' as color;

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List videoInfo = [];
  VideoPlayerController? _controller;
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) => setState(() {
              videoInfo = jsonDecode(value);
            }));
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.AppColor.gradientFirst.withOpacity(0.9),
                    color.AppColor.gradientSecond,
                  ],
                  begin: FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : BoxDecoration(
                color: color.AppColor.gradientSecond,
              ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _playArea == false
                ? Container(
                    padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: color.AppColor.secondPageIconColor,
                                size: 20,
                              ),
                            ),
                            Icon(
                              Icons.info_outline,
                              color: color.AppColor.secondPageIconColor,
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: 35),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Leg Toning\n"),
                              TextSpan(text: "and Glutes Workout"),
                            ],
                            style: TextStyle(
                              color: color.AppColor.secondPageTitleColor,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 20,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "68 min",
                                    style: TextStyle(
                                      color:
                                          color.AppColor.secondPageTitleColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    color: color.AppColor.secondPageIconColor,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Resitance band, kettlebell",
                                    style: TextStyle(
                                      color:
                                          color.AppColor.secondPageTitleColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )

                // The video list layout session
                : Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 70,
                            left: 20,
                            right: 20,
                          ),
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: color.AppColor.secondPageIconColor,
                                  size: 20,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.info_outline,
                                color: color.AppColor.secondPageIconColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: _playView(context),
                        ),
                        Slider(
                          value: max(0, min(_prograss * 100, 100)),
                          onChanged: (value) {
                            setState(() {
                              _prograss = value * 0.01;
                            });
                          },
                          onChangeStart: (value) {
                            _controller?.pause();
                          },
                          onChangeEnd: (value) {
                            final duration = _controller?.value.duration;
                            if (duration != null) {
                              var newValue = max(0, min(value, 99)) * 0.01;
                              var millis =
                                  (duration.inMilliseconds * newValue).toInt();
                              _controller
                                  ?.seekTo(Duration(milliseconds: millis));
                              _controller?.play();
                            }
                          },
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: _position?.toString().split(".")[0],
                          activeColor: Colors.red[200],
                          thumbColor: Colors.red[500],
                          inactiveColor: Colors.grey[300],
                        ),
                        _controlView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Circuit 1 : Legs Toning",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.loop,
                            size: 30,
                            color: color.AppColor.loopColor,
                          ),
                          Text(
                            "3 sets",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: videoInfo.length,
                          itemBuilder: (context, index) => VideoInfo(
                              onTap: () {
                                debugPrint(index.toString());
                                _initializeVideo(index);
                                _controlView(context);

                                setState(() {
                                  if (_playArea == false) {
                                    _playArea = true;
                                  }
                                });
                              },
                              image: videoInfo[index]["thumbnail"],
                              title: videoInfo[index]["title"].toString(),
                              time: videoInfo[index]["time"].toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo((remained % 60.0).toInt());
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 20,
                        color:
                            color.AppColor.secondPageContainerGradient1stColor),
                    BoxShadow(
                        offset: Offset(-5, -5),
                        blurRadius: 20,
                        color:
                            color.AppColor.secondPageContainerGradient1stColor)
                  ],
                ),
                child: Icon(
                  noMute ? Icons.volume_up : Icons.volume_off,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 60),
            TextButton(
              onPressed: () async {
                final index = _isPlayingIndex - 1;
                if (index >= 0 && videoInfo.length >= 0) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar(
                    "Video",
                    "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.info_outline,
                      size: 30,
                      color: Colors.white,
                    ),
                    messageText: Text(
                      "No videos ahead !",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: color.AppColor.gradientSecond,
                    margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                    colorText: Colors.white,
                  );
                }
              },
              child: Icon(
                Icons.fast_rewind,
                size: 30,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_isPlaying) {
                  setState(() {
                    _isPlaying = false;
                  });
                  _controller?.pause();
                } else {
                  setState(() {
                    _isPlaying = true;
                  });
                  _controller?.play();
                }
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 30,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () async {
                final index = _isPlayingIndex + 1;
                if (index <= videoInfo.length - 1) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar(
                    "Video",
                    "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(
                      Icons.info_outline,
                      size: 30,
                      color: Colors.white,
                    ),
                    messageText: Text(
                      "You have finished watching all the videos, Congrats !",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: color.AppColor.gradientSecond,
                    margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                    colorText: Colors.white,
                  );
                }
              },
              child: Icon(
                Icons.fast_forward,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 40),
            Text(
              "$mins:$secs",
              style: TextStyle(color: Colors.white, shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.1),
                  blurRadius: 4.0,
                  color: Color.fromARGB(150, 0, 0, 0),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Duration? _duration;
  Duration? _position;

  var _prograss = 0.0;

  var _onUpateControllerTime;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onUpateControllerTime > now) {
      return;
    }
    final controller = _controller;
    if (controller == null) {
      debugPrint("Controller is null");
      return;
    }
    _onUpateControllerTime = now + 500;

    if (!controller.value.isInitialized) {
      debugPrint("Controller can not be initialized");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _prograss = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }

    _isPlaying = playing;
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;

    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return Center(
          child: Text(
        "Progress...",
        style: TextStyle(color: Colors.white),
      ));
    }
  }

  _initializeVideo(int index) async {
    final controller = VideoPlayerController.network(
      (videoInfo[index]["videoUrl"]),
    );
    final old = _controller;
    if (old != null) {
      old.removeListener(() => _onControllerUpdate());
      old.pause();
    }

    _controller = controller;
    setState(() {});
    controller
      ..initialize().then((value) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(() => _onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }
}
