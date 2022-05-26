
import 'package:http/http.dart';



getVideoDataofInsta(String s)async{

  var lst = s.split("/");
  var li = lst.length;
  var url = "";

  if(lst[li-1].contains("?")){
    lst.removeAt(li-1);
  }


  lst.forEach((element) {
    url+=element;
    url+="/";
  });




 // Response dt = await get(Uri.parse(url));


  //var st = dt.body;






}