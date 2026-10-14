import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherInfo {
  const WeatherInfo({
    required this.temperature,
    required this.windSpeed,
    required this.condition,
  });

  final num temperature;
  final num windSpeed;
  final String condition;
}

class WeatherService {
  static final Uri _weatherUrl = Uri.parse(
    'https://api.open-meteo.com/v1/forecast'
    '?latitude=10.05&longitude=124.01'
    '&current=temperature_2m,wind_speed_10m,weather_code'
    '&timezone=Asia%2FManila',
  );

  Future<WeatherInfo> fetchWeather() async {
    final response = await http
        .get(_weatherUrl)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Weather service returned ${response.statusCode}.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final current = data['current'] as Map<String, dynamic>?;
    if (current == null) {
      throw const FormatException('Weather data is missing.');
    }

    final temperature = current['temperature_2m'];
    final windSpeed = current['wind_speed_10m'];
    final weatherCode = current['weather_code'];
    if (temperature is! num || windSpeed is! num || weatherCode is! num) {
      throw const FormatException('Weather data has an unexpected format.');
    }

    return WeatherInfo(
      temperature: temperature,
      windSpeed: windSpeed,
      condition: _conditionFor(weatherCode.toInt()),
    );
  }

  String _conditionFor(int code) {
    if (code == 0) return 'Clear sky';
    if (code <= 3) return 'Partly cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 67) return 'Rainy';
    if (code <= 77) return 'Snowy';
    if (code <= 82) return 'Rain showers';
    if (code <= 86) return 'Snow showers';
    return 'Thunderstorms';
  }
}
