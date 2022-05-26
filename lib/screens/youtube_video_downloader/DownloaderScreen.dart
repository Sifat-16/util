import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:util/screens/youtube_video_downloader/yt_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Yout extends StatefulWidget {
  const Yout({Key? key}) : super(key: key);

  @override
  _YoutState createState() => _YoutState();
}

class _YoutState extends State<Yout> {

  TextEditingController txt = TextEditingController();
  int avail = 0;
  int avail2 = 0;
  int availLink=0;
  Future<Video?>? myVd;
  Future<UnmodifiableListView<MuxedStreamInfo>?>? myVidsLinks;
  List<MuxedStreamInfo> mylists = [];

  static void downloadCallBack(String id, DownloadTaskStatus status, int progress){}


  @override
  void initState() {
    FlutterDownloader.registerCallback(downloadCallBack);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Youtube Video Downloader"),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: txt,
              onChanged: (s){
                setState(() {
                  if(s.length==0){
                    avail=0;
                  }else{
                    avail=1;
                  }
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(icon: Icon(Icons.delete),
                  onPressed: (){
                    txt.clear();
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                hintText: "Paste link here",

              ),
            ),

            ElevatedButton(onPressed: (){
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

              String s = txt.text.toString();
              setState(() {
                avail2 = 1;
                availLink=0;
                myVd = getYoutubeVideoData(s);

              });
            },
              child: Text("Generate Link"),
              style: ButtonStyle(
                  backgroundColor: avail==0?MaterialStateProperty.all<Color>(Colors.grey):MaterialStateProperty.all<Color>(Colors.green)
              ),
            ),

            Visibility(
                visible: avail2==0?false:true,
                child:FutureBuilder<Video?>(
                    future: myVd,
                    builder: (context, snapshot){
                      var item = snapshot.data;

                      return snapshot.hasData?myWidget(item!):CircularProgressIndicator();
                    }
                )
            )

          ],
        ),
      ),
    );
  }

  myWidget(Video vd){
    if(availLink==0){
      mylists.clear();
      myVidsLinks = getStreamDownload(vd.id.toString());
      myVidsLinks!.then((value) {
        value!.forEach((element) {
          mylists.add(element);
        });
        setState(() {
          availLink=1;
        });

      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(vd.title, style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        Image.network(vd.thumbnails.standardResUrl),


        Container(
          height: MediaQuery.of(context).size.height*.35,
          child: Visibility(
              visible: availLink==0?false:true,
              child: ListView.builder(
                  itemCount: mylists.length,
                  itemBuilder: (context, index){
                    var it = mylists[index];
                    return ListTile(

                      title: ElevatedButton(
                        onPressed: (){
                          downloadVideo(it, vd);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${it.qualityLabel}"),
                            Text("${it.size}")
                          ],
                        ),
                      ),
                    );
                  }
              )
          ),
        ),




      ],
    );
  }
}