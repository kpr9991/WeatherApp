import 'package:http/http.dart' as http;   //'as' ane keyword use cheyatam valla for example mana imported package 'http' lo direct get ane method undi so direct get ani vaadithe assalu ee function deiki ssambanchinadhi ani teliselledu kadha.So adhi teliyataniki we used 'as http',Next time yekkada use chesina we can write http.andsomething.
import 'dart:convert';

class NetworkHelper{

  final url;

  NetworkHelper({this.url});

  Future<dynamic> getNetworkData() async                   //Decoded object yokka type teliyadhu kadha ,yedukante json object type runtime lo decide avuthundi and so for that we used Future as return type and inko reason idhi by default asynchronus kabatti.
  {
    http.Response response=await  http.get(url);
    if(response.statusCode==200)
    {
      var decodedObject=jsonDecode(response.body);                    //Remember to keep this decoded body as var data type because we dont ever know what is the type of the object that is being sent.
      return decodedObject;
    }
    else
      print(response.statusCode);

  }
}