import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final double temperature;
  final int humidity;
  final int pressure;


  WeatherData({this.temperature, this.humidity, this.pressure});

  @override
  // TODO: implement props
  List<Object> get props => [temperature];

  double get temp => temperature;

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(temperature: json["temp"], humidity: json["humidity"], pressure: json["pressure"]);
  }
}
