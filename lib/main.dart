import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_weather_app/BLoC/weather_event.dart';
import 'package:real_weather_app/BLoC/weather_bloc.dart';
import 'package:real_weather_app/BLoC/weather_state.dart';
import 'package:real_weather_app/Model/weatherData.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: BlocProvider(
          create: (context) => WeatherManageBloc(),
          child: WeatherInfo(),
        ));
  }
}

class WeatherInfo extends StatefulWidget {
  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  TextEditingController controller = TextEditingController();
  final weatherBloc = WeatherManageBloc();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherManageBloc>(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           child: BlocBuilder(
          bloc: weatherBloc,
          builder: (context, state) {
            if (state is NotSearchingState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Type in any city to find out weather",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search city",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        height: 40.0,
                        width: double.infinity,

                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.orangeAccent,
                              onSurface: Colors.grey,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                            ),
                          onPressed: () {
                            weatherBloc.add(CatchCityDataFromSearchBar(
                                cityName: controller.text));
                          },
                          child: Text("Search"),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is SearchingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchedState) {
              return ShowData(state.weatherData, controller.text);
            }
          },
        ),
      ),
    ));
  }
}

class ShowData extends StatelessWidget {
  final WeatherData data;
  final String cityName;

  const ShowData(this.data, this.cityName);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.0,
                  ),
                  Text("Temperature in $cityName is" + " " + data.temp.toString() +"°F",style: TextStyle(
                      fontSize: 25)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Humidity:" + data.humidity.toString() + "%",style: TextStyle(
                      fontSize: 25)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Pressure:" + data.pressure.toString() + " hPa",style: TextStyle(
                      fontSize: 25)),
                ]
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.orangeAccent,
                  onSurface: Colors.grey,
                  elevation: 20,
                ),
                onPressed: () {
                  BlocProvider.of<WeatherManageBloc>(context)
                      .add(ResetWeatherData());
                },
                child: Text("Go back"),
              ),

            )
          ],
        ),
      ),
    );
  }
}
