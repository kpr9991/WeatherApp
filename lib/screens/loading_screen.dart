import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
//Ee convert package use chesi we can fetch the json object content.

//1.Basic idea behind using await and async is that,oka method yokka return type async ante aa method will return a Future
//response ante it will do its work and return after sometime ani it will not stop other methods from running ani.Ante aa method
//daani paatiki adhi work chestu vere method ni stop cheyakunda, untadhi ani.
//2.So adhi future response iste manaki matram data kachchitanga kavali anuko manam await use chesi
//danni wait cheyamani cheppi aa tarvaatha return data raagane proceed avutham ,Ala wait cheyanivvataniki we use await.
//await key word use cheste async modifier ni pettali.
//3.Note that return type future ani undante adhi asynchronous method ani.


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    //Note that we cannot make initstate as the async method but we can make a fucntion as async and call the method
    super.initState();
    getCurrentLocation();
  }
  //Logic yentante asynchronous methods nundi return ayye objects are of type Future<type> because they perform asynchronously and we dont know when they are gonna return data.
  //Adhe synchronous methods ki just "return type" pedithe chaalu and no need Future keyword.
  //But oka function asynchronous ani neeku telsinappudu daani nundi data asynchronous ga vasthundi ani telsinappudu,but neeku
  //pucca synchronous ga kaavali annappudu "async" keyword ni aa function chuttu petti await ani aa function lopala yedanna function call to nonsynchronous function ki call unte daani
  //starting lo pedthaadu,so ila await ani pettave anuko appudu you dont need to take the Future object just take original object.
  //Ippudu ikkada kindha unna getCurrentLocation ane method lo location ane object create chesi aa object tho getlocation ni access chestunnav,So daani
  //valla neeku vasthundi pucca result ani telsu ,kaneesam default anna vasthundi ani telsu,but idhi vere dart file kabatti
  //Nuvvu getCurrentlocation lo location.getlocation ni normal function call la pettachcu by removing the async keyword
  //and await keyword,But nuvvu vere file lo unnav anukoni neeku aa file lo yem jaruguthundo teliyadhu annappudu
  //adhi asynchronous ani anukoni basic ga getCurrentLocation ani piliste neeku location vachchentavaraku wait
  //cheyali kabatti,denni kuuda async keyword tho wrap chesi await ani pettali function call ki venaka.
  //So thus location.dart nundi return ayyedi asynchronous return value ne ani nuv fix ayyav kabatti location.dart lo
  //velli future return type ni pettu.Yendukane asynchrounous methods ki return type future object ayyundali.

  void getCurrentLocation() async {
    WeatherModel weatherModel=WeatherModel();
    var weatherData=await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationweather: weatherData,);//Yekkadanna oka screen ki inko screen ki madhya data ni pass cheyali,aa screen ki object ni create chestunnappudu constructor use chesi pampali.
    }));
  }

  //Response object ni future response ga pettali ususal ga yeppudaithe nuvvu 'get' method ni asynchronous ga pani chey ani cheptunnavo appudu.But since ikkada neeku first data kavali aa tarvaathe next pani jaragali kabatti,We used 'async' keyword and 'await' and made that to wait until we get that data and then we proceeded

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:SpinKitDoubleBounce(color: Colors.white70,size:100,)),
    );
  }
}
