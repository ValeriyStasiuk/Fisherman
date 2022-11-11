// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;

  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }
  @override
  void dispose(){
    _disposed=true;
    _controller?.pause();
    _controller?.dispose();
    _controller=null;
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea==false?BoxDecoration(
          gradient: LinearGradient(
        colors: [
          color.AppColor.gradientFirst.withOpacity(0.9),
          color.AppColor.gradientSecond
        ],
        begin: const FractionalOffset(0.0, 0.4),
        end: Alignment.topRight,
      )):BoxDecoration(
        color:color.AppColor.gradientSecond,
      ),
      child: Column(
        children: [
          _playArea==false?Container(
            padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios,
                          size: 20, color: color.AppColor.secondPageIconColor),
                    ),
                    Expanded(child: Container()),
                    Icon(Icons.info_outline,
                        size: 20, color: color.AppColor.secondPageIconColor),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Корисні відео",
                  style: TextStyle(
                      fontSize: 25, color: color.AppColor.secondPageTitleColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "та просто для душі",
                  style: TextStyle(
                      fontSize: 25, color: color.AppColor.secondPageTitleColor),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
              
                    Container(
                        width: 220,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                color.AppColor
                                    .secondPageContainerGradient1stColor,
                                color.AppColor
                                    .secondPageContainerGradient2ndColor
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.handyman_outlined,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Valeriy Stasiuk, KPNU",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                              )
                            ]))
                  ],
                ),
                // SizedBox(width: 20,),
              ],
            ),
          ):Container(
           //123
           child:Column(
             children: [
              Container(
                height:100,
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child:Row(children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child:Icon(Icons.arrow_back_ios, size: 20, color: color.AppColor.secondPageIconColor)
                  ),
                Expanded(child: Container()),
                Icon(Icons.info_outline,
                size: 20, color: color.AppColor.secondPageTopIconColor)
                ],)
                
              ),
              _playView(context),
              _controlView(context),
             ],
           )
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
            Row(
              children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text("Приємного перегляду",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor)),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(Icons.loop,
                          size: 30, color: color.AppColor.loopColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("",
                          style: TextStyle(
                            fontSize: 15,
                            color: color.AppColor.setsColor,
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ]),
                SizedBox(height: 20,),
                Expanded(child: _listView(),)
           
              ],
            ),
          ))
        ],
      ),
    )); 
  }

var _onUpdateControllerTime;
void _onControllerUpdate()async{
  if(_disposed){
    return;
  }

  _onUpdateControllerTime = 0;
  final now = DateTime.now().millisecondsSinceEpoch;
  if(_onUpdateControllerTime>now){
    return;
  }

  _onUpdateControllerTime=now+500;

  final controller = _controller;
  if(controller==null){
    debugPrint("controller is null");
    return;
  }
  if(!controller.value.isInitialized){
    debugPrint("controller is not initialized");
    return;
  }
  final playing = controller.value.isPlaying;
  _isPlaying=playing;
}

_onTapVideo(int index) {
  final controller = VideoPlayerController.network(videoInfo[index]["videoUrl"]);
  final old = _controller;
  _controller = controller;
  if(old!=null){
    old.removeListener(_onControllerUpdate);
    old.pause();
  }
  setState(() {
    
  });
  controller..initialize().then((_){
    old?.dispose();
    _isPlayingIndex = index;
    controller.addListener(_onControllerUpdate);
    controller.play();
    setState(() {
      
    });
  });
}

Widget _controlView(BuildContext context){
  return Container(
    height: 120,
    width: MediaQuery.of(context).size.width,
    color:color.AppColor.gradientSecond,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: ()async {
            final index = _isPlayingIndex-1;
            if(index>=0&&videoInfo.length>=0){
               _onTapVideo(index);
            }
            else{
              Get.snackbar("Video", "No more video to play");
            }
          },
          child: Icon(Icons.fast_rewind, size:36,color:Colors.white,)
        ),
        FlatButton(
          onPressed: () {
            if(_isPlaying){
              setState(() {
                _isPlaying=false;
              });
              _controller?.pause();
            } else {
               setState(() {
                _isPlaying=true;
              });
              _controller?.play();
            }
          },
          child: Icon( _isPlaying?Icons.pause: Icons.play_arrow,size:36,color:Colors.white,)
        ),
        FlatButton(
          onPressed: ()async {
            final index = _isPlayingIndex+1;
            if(index<=videoInfo.length-1){
              _onTapVideo(index);
            }else{
              Get.snackbar("Video List", "No more video i the list");
            }
          },
          child: Icon(Icons.fast_forward,size:36,color:Colors.white,)
        ),
      ],
    ),
  );
}

Widget _playView(BuildContext context) {
  final controller =_controller;
  if(controller!=null && controller.value.isInitialized) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: VideoPlayer(controller),
    );
  } else {
    return AspectRatio(
      aspectRatio: 16/9,
      child: Center(child: Text("Preparing...",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white60
      ),
      ),
      ));
  }
}

  _listView() {
    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        itemCount: videoInfo.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              _onTapVideo(index);
                              debugPrint(index.toString());
                              setState(() {
                                if (_playArea==false){
                                  _playArea = true;
                                }
                              });
                            },
                            child: _buildCard(index) 
                          );
                        },);
  }
  _buildCard (int index) {
    return Container(
                      height: 135,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        videoInfo[index]["thumbnail"]
                                                            ),
                                                            fit:BoxFit.cover
                                                          ),
                                                        ),
                                                      ),
                                                          
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text(
                                          videoInfo[index]["title"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: EdgeInsets.only(top:3),
                                          child: Text(
                                            videoInfo[index]["time"],
                                            style: TextStyle(
                                              color:Colors.grey[500]
                                            )
                                          )

                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                     SizedBox(height: 18,),  
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color:Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "KPNU", style: TextStyle(
                        color:Color(0xFF839fed),
                      ),
                    ),
                  ),
                ),
                Row(children: [
                  for(int i = 0; i<70;i++)
                  i.isEven?Container(
                    width: 3,
                    height: 1,
                    decoration: BoxDecoration(
                      color:Color(0xFF839fed),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ):Container(
                    width: 3,
                    height: 1,
                    color:Colors.white,
                  ),
                ],),
              ],
            ),
          ],
        ),
      );
  }
}
