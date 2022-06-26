// ignore_for_file: avoid_print

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String url;
  late String flag;
  late bool isdaytime = true;
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //print(data['utc_offset']);

      String sign = data['utc_offset'].substring(0, 1);
      //print(sign);

      String datetime = data['datetime'];

      String offset1 = data['utc_offset'].substring(0, 3);
      //print(offset1);

      String offset2 = sign + data['utc_offset'].substring(4, 6);
      //print(offset2);

      DateTime now = DateTime.parse(datetime);
      //print(now);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      time = DateFormat.jm().format(now);
      isdaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('caught error $e');
      time = 'could not get data';
    }
  }
}
