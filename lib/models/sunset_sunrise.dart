class SunsetSunrise {
  final String sunrise;
  final String sunset;

  const SunsetSunrise({required this.sunset, required this.sunrise});

  factory SunsetSunrise.fromJson(Map<String, dynamic> json) {
    final results = json['results'];
    return SunsetSunrise(
      sunrise: results['sunrise'],
      sunset: results['sunset'],
    );
  }
}
