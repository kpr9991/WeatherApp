import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationweather;
  LocationScreen(
      {this.locationweather}); //So ikkada unna stateful widget class  lo unna property ni kindha unna location screen state classs lo access cheyalem yendukante rendu seperate classes kabatti now,
  //Daaniki unna inko way use widget method predefined.

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int c=0;
  //Location screens state object.
  WeatherModel weatherModel = WeatherModel();
  String cityName;
  String FinalString;
  int temperature; //Temperature anedi double type kabatti,antha accurate ga avasaram ledu kabatti,danni integer chestunnam.
  String weatherIcon;
  String messageForTemperature;
  @override
  void initState() {
    //EE initstate locationscreenstate ki object create chesina ventane pilavabaduthundi.
    updateUI(widget.locationweather);
  }

  void updateUI(dynamic weatherData) { //If in case because of some problems if weather data becomes NULL then that object must not be called and so daani kosame manam
    if(weatherData==null)
      {
        setState(() {
          messageForTemperature="City Name ra labbe";
          temperature=0;
          FinalString=messageForTemperature;
        });
        return;
      }
    setState(() {                                         //Next time update UI ni piluste aa variables setstate lo evi unte avi unna build method rebuild avvali kabatti,We used setstate.
    cityName = weatherData["name"];
    temperature = weatherData["main"]["temp"].toInt();
    var condition = weatherData['weather'][0]['id'];
    weatherIcon = weatherModel.getWeatherIcon(condition);
    messageForTemperature = weatherModel.getMessage(temperature);
    FinalString='$messageForTemperature in $cityName!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{                       //ikkada very most important thing yentante onpressed ni async cheyakkapothe we get an error in the console, and the interface does not get updated,this is because getlocationweather ane method asynchronous ga work chestundi,So adhi return chesina cheyaakapoyina updateUI run ayipoyi errors vachhcestayi.So deeni avoid cheyali ante we have to use await keyword behind getlocationWeather and daani kosam we have to make onpressed method as async.
                      var weatherData= await WeatherModel().getLocationWeather();  //Ee button press avvagane oka object create chesi aa object tho weather data ni teesukni UI ni aa updated content tho rebuild chestunnam.
                      updateUI(weatherData);                               //Ee weather data tho update avvali ga UI.
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder:(context){return CityScreen();})); //Indaka ikkade ga city Screen ki redirect chesindi,So by default akkada nundi yemanna data return cheste pop chesinappudu aa data ikkada return cheskoni use cheskovachchu,ikkada CityName ni nen use chesinattu.
                    if(typedName!=null) {
                      var weatherData = await WeatherModel()
                          .getLocationWeatherByCityName(typedName);
                      updateUI(weatherData);
                    }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  FinalString,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
