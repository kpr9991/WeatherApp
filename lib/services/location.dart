import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  Future<void> getLocation() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e)
    {
      position=position??Position(latitude: 10.0,longitude: 10.0);     //?? operator is used to check the null result,i.e if the position is not NULL then it will proceed with the value or else it assigns the value given after ??
      latitude=position.latitude;
      longitude=position.longitude;
    }
    }                                                                 //Basically location ravalante time pattudhhi kabatti location ni techche function will be asynchronous,ante adhi complete ayyina avvakapoyina migathavi run ayitai.But mana app lo location important kabatti adhi raakunda work cheyaledu kabatti await functionn use chesi aa location vachchentha varaku wait cheyamani cheptunnam.}

  }

