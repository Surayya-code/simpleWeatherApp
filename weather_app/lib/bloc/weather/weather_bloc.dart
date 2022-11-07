import 'package:bloc/bloc.dart';
import 'package:weather_app/data/service/weather_service.dart';

import '../../data/model/weather_fetch_model.dart';
import '../../global/error/global_failure_error.dart';
import 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService _weatherService = WeatherService();
  final GlobalFailureError _globalFailureError = GlobalFailureError();
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      emit(WeatherFetchLoading());
      if (event is WeatherFetchEvent) {
        final result = await _weatherService.fetchWeatherInfo(event.cityName);
         /* -------------------------------------------------------------------------- */
         /*                              WeatherFetchModel                             */
         /* -------------------------------------------------------------------------- */
        if (result is WeatherFetchModel) {
          emit(WeatherFetchSuccess(weatherInfo: result));
          /* -------------------------------------------------------------------------- */
          /*                                   Default                                  */
          /* -------------------------------------------------------------------------- */
        } else {
          emit(WeatherFetchFailure(failureMessage: _globalFailureError));
        }
      }
    });
  }
}
