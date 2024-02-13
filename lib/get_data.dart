import 'dart:convert';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;



class Data
{

  static Future<CurrentWeather> getWeather(String city) async{

    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&lang=fa&APPID=dcfa1858382a3c71636ea4cfa417f727&units=metric');

    var response = await http.get(url);

    if(response.statusCode==404)
      {
        url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Amol&lang=fa&APPID=dcfa1858382a3c71636ea4cfa417f727&units=metric');

        response = await http.get(url);
      }

    return CurrentWeather.fromJson(jsonDecode(response.body));

  }

  static String getCapcha(String c){
    if(c.length>5)
      {
        c = c.substring(0, 5);
      }
    if(c==''){c='kh';}
    return 'https://api.codebazan.ir/captcha/?font=1&bg=1&textcolor=1&text=$c';

  }


}