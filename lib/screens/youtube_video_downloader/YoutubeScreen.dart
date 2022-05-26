import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'DownloaderScreen.dart';


class YoutubeScreen extends StatefulWidget {
  YoutubeScreen({Key? key, required this.pageController}) : super(key: key);
  PageController pageController;
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
              widget.pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          },

        ),
        title: Text("Youtube"),
      ),

      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://www.youtube.com/",
        onWebViewCreated: (controller){
          setState(() {
            this.controller=controller;
          });


        },
        onPageFinished: (s) {
          controller.evaluateJavascript(
                "document.getElementById('items').style.display='none'"
          );
        },
      ),
    );
  }
}
