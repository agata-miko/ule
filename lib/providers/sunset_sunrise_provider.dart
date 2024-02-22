import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'package:pszczoly_v3/models/sunset_sunrise.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final sunsetSunriseProvider =
StateNotifierProvider<SunsetSunriseNotifier, SunsetSunrise?>(
        (ref) => SunsetSunriseNotifier());

class SunsetSunriseNotifier extends StateNotifier<SunsetSunrise?> {
  SunsetSunriseNotifier() : super(null);

  Future<SunsetSunrise?> fetchData() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();
    final double? latitude = currentLocation.latitude;
    final double? longitude = currentLocation.longitude;

    final response = await http
        .get(Uri.parse(
        'https://api.sunrisesunset.io/json?lat=$latitude&lng=$longitude'));

    if (response.statusCode == 200) {
      return SunsetSunrise.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(AppLocalizations.of(context as BuildContext)!.loadingDataFailed);
    }
  }
}