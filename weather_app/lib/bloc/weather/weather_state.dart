part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherFetchLoading extends WeatherState {}

class WeatherFetchSuccess extends WeatherState {
  final WeatherFetchModel weatherInfo;
  WeatherFetchSuccess ({required this.weatherInfo});
}

class WeatherFetchFailure extends WeatherState {
  final GlobalFailureError failureMessage;
  WeatherFetchFailure({required this.failureMessage});

}
