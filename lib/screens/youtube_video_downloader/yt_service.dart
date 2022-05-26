import 'dart:collection';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';




Future<Video?> getYoutubeVideoData(String s) async{

  if(s.length==0){
    return null;
  }

  var spl = s.split("/");
  var id = "";
  if(spl.contains("shorts")){
    var il = 0;
    for(int i = 0;i<spl.length;i++){
      if(spl[i]=="shorts"){
        il = i+1;
        break;
      }
    }
    var spl2 = spl[il].split("?");
    id = spl2[0];
  }else{
    for(int i=s.length-1;i>=0;i--){
      if(s[i]=='='||s[i]=='/'){
        break;
      }else{
        id+=s[i];
      }
    }
    id = id.split('').reversed.join('');
  }




  var yt = YoutubeExplode();

  var vd = await yt.videos.get('https://youtube.com/watch?v=$id');
  yt.close();

  return vd;


}

Future<UnmodifiableListView<MuxedStreamInfo>?>getStreamDownload(String id) async{

  var yt = YoutubeExplode();

  var manifest =await yt.videos.streamsClient.getManifest(id);

  var streamInfo = manifest.muxed;

  yt.close();
  return streamInfo;


}


downloadVideo(MuxedStreamInfo streamInfo, Video vd) async{

  final status = await Permission.storage.status;

  if(status==PermissionStatus.denied||status==PermissionStatus.permanentlyDenied){
    final st = await Permission.storage.request();
    if(st.isGranted){


      final appStorage = await getExternalStorageDirectory();
      var path = appStorage!.path.split("/");
      var npth = "";
      for(int x=1;x<path.length;x++){
        var s = path[x];
        if(s!="Android"){
          npth+="/"+s;
        }else{
          break;
        }
      }
      npth+="/Siftil";
      Directory nd = Directory(npth);
      bool ex = await nd.exists();
      if(!ex){
        nd.create();
      }
      var tl = vd.title.replaceAll(" ", "");
      tl = tl.replaceAll("/", "");
      tl=tl.toLowerCase();
      print(tl);

     var id = FlutterDownloader.enqueue(url: streamInfo.url.toString(),fileName: "$tl${streamInfo.qualityLabel}.${streamInfo.container.name}", savedDir: nd.path, showNotification: true, openFileFromNotification: true);

      print(path);

    }
  }else{



    final appStorage = await getExternalStorageDirectory();
    var path = appStorage!.path.split("/");
    var npth = "";
    for(int x=1;x<path.length;x++){
      var s = path[x];
      if(s!="Android"){
        npth+="/"+s;
      }else{
        break;
      }
    }
    npth+="/Siftil";
    Directory nd = Directory(npth);
    bool ex = await nd.exists();
    if(!ex){
      nd.create();
    }

    var tl = vd.title.replaceAll(" ", "");
    tl = tl.replaceAll("/", "");
    tl=tl.toLowerCase();
    print(tl);

    FlutterDownloader.enqueue(url: streamInfo.url.toString(),fileName: "$tl${streamInfo.qualityLabel}.${streamInfo.container.name}", savedDir: nd.path, showNotification: true, openFileFromNotification: true);


  }


}

