import 'package:geocoding/geocoding.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';
import 'package:mms_app/core/api/weather_api.dart';
import 'package:mms_app/core/models/current_weather.dart';
import 'package:mms_app/core/utils/custom_exception.dart';

import '../../locator.dart';
import 'base_vm.dart';

class WeatherViewModel extends BaseModel {
  final WeatherApi _authApi = locator<WeatherApi>();
  String error;
  CurrentWeather currentWeather;
  String location;

  Future<void> getCurrentData(double lat, double lng) async {
    print({lat, lng});
    setBusy(true);
    List<Placemark> result = await placemarkFromCoordinates(lat, lng);
    if (result == null) {
      dialog.showDialog(
        title: 'Error',
        description: 'Error Decoding Location',
        buttonTitle: 'Close',
      );
      setBusy(false);
      return;
    }
    location = result.first.locality ??
        result.first.administrativeArea ??
        result.first.country;
    try {
      currentWeather = await _authApi.getCurrentData(location);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  Future<void> getHistoryData(String where) async {
    setBusy(true);
    try {
      currentWeather = await _authApi.getHourlyData(where);
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
      showDialog(e);
    }
  }

  void showDialog(CustomException e) {
    dialog.showDialog(
        title: 'Error', description: e.message, buttonTitle: 'Close');
  }
}
