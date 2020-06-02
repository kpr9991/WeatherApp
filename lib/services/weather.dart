import '../services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey =
    '559340dd86fcb83340111729e6240a0e'; //This apikey would never change.
const openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather'; //Ee URL tavaatha vachchedi change avuthundi.

class WeatherModel {

  Future<dynamic> getLocationWeatherByCityName(String cityName) async{
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getNetworkData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location =
        Location(); //So ee location object lo you will get the longitude and latitude into that object when the getlocation method is called (The get location method in the location class).
    await location
        .getLocation(); //Akkada wait pettindi geolocator nundi latitude and longitutde vachchentha varaku function yemi return cheyakudadhu ani,Ikkada async and await pettindi aa method complete ayyentha varaku next step ki vellakuudadhu ani.So neeku yekkada function ni wait cheyali ani anipiste akkada async petti await lopala pettali,and aa lopala jarige function asynchronoous kaakapthe await pettatam valla use ledu.But basic ga chaala yekkuva data ni load cheyali lekunte yekkuva time consuming data ante (Like location lantivi load cheyali ante package create chesevallu aa function asynchronus ga thana pani//thanu chuskunela create chesintaru,So manaku matram aa data vachchina tarvaathe panulu jaruguthayi kabatti manam  danni await cheyanistam async ane modifier use chesi.Note that await ani pettav ante yedanna function call ki appudu aa function return value (manam teesukunedi and oka vela nuvvu funciton create chesinte  aa function kuuda) kachcitanga future object return type ayyundali,yendukante adhi depends on runtime kadha.
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'); //Units metric ante,celsius lo temperature vasthundi,Adhe imperial ante fahrenheit.//Note that ikkada $location.something ante $ symbol location variable location varake pani chesthundi so ${location.somex} ala flower brackets ni pettali,Note that round brackets pani cheyavu.
    var weatherData = await networkHelper
        .getNetworkData(); //Aa network helper daggaranundi we are gettnig the data and,aa data ni manam locationscreen.dart file ki pampinchali to use that data and print there.
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩'; //Emojis and strings are processed in the same way.So ee emojis ni open weather api nundi techcharu,EE emojis condition ni patti mana screen paina eh amoji kavalante aa emoji print cheyachchu.
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Yekkuva ledu Takkuva ledu  ';
    } else if (temp > 20) {
      return 'Chilled ga untundi 👕';
    } else if (temp < 10) {
      return 'Chali Champuthundi ivi vesko 🧣 , 🧤';
    } else {
      return 'Jacket 🧥 vesko machcha';
    }
  }
}
