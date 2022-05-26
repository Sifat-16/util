import 'package:flutter/material.dart';
import 'package:util/screens/instagram_video_downloader/insta_service.dart';

class InstaDownloader extends StatefulWidget {
  const InstaDownloader({Key? key}) : super(key: key);

  @override
  _InstaDownloaderState createState() => _InstaDownloaderState();
}

class _InstaDownloaderState extends State<InstaDownloader> {

  TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Instagram video downloader"),
      ),

      body: Column(
        children: [
          TextField(
            controller: txt,
            onChanged: (s){

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

            getVideoDataofInsta(s);

          },
            child: Text("Generate Link"),

          ),


        ],
      ),

    );
  }
}
