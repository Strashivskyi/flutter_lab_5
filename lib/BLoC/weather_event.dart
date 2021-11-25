import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CatchCityDataFromSearchBar extends WeatherEvent {
  final String cityName;

  CatchCityDataFromSearchBar({this.cityName});

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}

class ResetWeatherData extends WeatherEvent{
  
}
