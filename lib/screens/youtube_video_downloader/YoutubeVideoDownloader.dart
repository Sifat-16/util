import 'dart:collection';


import 'package:flutter/material.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:util/screens/youtube_video_downloader/YoutubeScreen.dart';
import 'package:util/screens/youtube_video_downloader/yt_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'DownloaderScreen.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({Key? key}) : super(key: key);

  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {

  int current_index=0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          setState(() {
            current_index=index;
          });
        },
        scrollDirection: Axis.horizontal,
        children: [
          Yout(),
          YoutubeScreen(pageController: _pageController,)

        ],
      ),


      bottomNavigationBar: BottomNavigationBar(
          currentIndex: current_index,
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(

                icon: Icon(Icons.download_outlined),
                label: "Downloader"
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.youtube_searched_for),
                label: "Youtube"
            ),
          ]),


    );
  }
}





