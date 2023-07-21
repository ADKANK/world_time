import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String location;
  String? time = "";
  String? flag;
  String? url;
  bool? isDayTime;

  WorldTime({ required this.location, required this.flag, required this.url});
  Future<void> getTime() async{
    try {
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
          Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(dateTime);
      // print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      //set the time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("error message : $e");
      time = "time not found";
    }


  }

}