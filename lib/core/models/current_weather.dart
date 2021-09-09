class CurrentWeather {
  Request request;
  Location location;
  Current current;

  CurrentWeather({this.request, this.location, this.current});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    current =
        json['current'] != null ?   Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    return data;
  }
}

class Request {
  String type;
  String query;
  String language;
  String unit;

  Request({this.type, this.query, this.language, this.unit});

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query'];
    language = json['language'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['query'] = this.query;
    data['language'] = this.language;
    data['unit'] = this.unit;
    return data;
  }
}

class Location {
  String name;
  String country;
  String region;
  String lat;
  String lon;
  String timezoneId;
  String localtime;
  int localtimeEpoch;
  String utcOffset;

  Location(
      {this.name,
      this.country,
      this.region,
      this.lat,
      this.lon,
      this.timezoneId,
      this.localtime,
      this.localtimeEpoch,
      this.utcOffset});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    region = json['region'];
    lat = json['lat'];
    lon = json['lon'];
    timezoneId = json['timezone_id'];
    localtime = json['localtime'];
    localtimeEpoch = json['localtime_epoch'];
    utcOffset = json['utc_offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['region'] = this.region;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone_id'] = this.timezoneId;
    data['localtime'] = this.localtime;
    data['localtime_epoch'] = this.localtimeEpoch;
    data['utc_offset'] = this.utcOffset;
    return data;
  }
}

class Current {
  String observationTime;
  int temperature;
  int weatherCode;
  List<String> weatherIcons;
  List<String> weatherDescriptions;
  int windSpeed;
  int windDegree;
  String windDir;
  int pressure;
  double precip;
  int humidity;
  int cloudcover;
  int feelslike;
  int uvIndex;
  int visibility;
  String isDay;

  Current(
      {this.observationTime,
      this.temperature,
      this.weatherCode,
      this.weatherIcons,
      this.weatherDescriptions,
      this.windSpeed,
      this.windDegree,
      this.windDir,
      this.pressure,
      this.precip,
      this.humidity,
      this.cloudcover,
      this.feelslike,
      this.uvIndex,
      this.visibility,
      this.isDay});

  Current.fromJson(Map<String, dynamic> json) {
     temperature = json['temperature'];
     weatherIcons = json['weather_icons'].cast<String>();
    weatherDescriptions = json['weather_descriptions'].cast<String>();

    humidity = json['humidity'];

    windSpeed = json['wind_speed'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['observation_time'] = this.observationTime;
    data['temperature'] = this.temperature;
    data['weather_code'] = this.weatherCode;
    data['weather_icons'] = this.weatherIcons;
    data['weather_descriptions'] = this.weatherDescriptions;
    data['wind_speed'] = this.windSpeed;
    data['wind_degree'] = this.windDegree;
    data['wind_dir'] = this.windDir;
    data['pressure'] = this.pressure;
    data['precip'] = this.precip;
    data['humidity'] = this.humidity;
    data['cloudcover'] = this.cloudcover;
    data['feelslike'] = this.feelslike;
    data['uv_index'] = this.uvIndex;
    data['visibility'] = this.visibility;
    data['is_day'] = this.isDay;
    return data;
  }
}
