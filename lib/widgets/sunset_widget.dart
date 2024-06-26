import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/models/sunset_sunrise.dart';
import 'package:pszczoly_v3/providers/sunset_sunrise_provider.dart';

class SunsetWidget extends ConsumerWidget {
  const SunsetWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF233406),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<SunsetSunrise?>(
        future: ref.read(sunsetSunriseProvider.notifier).fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(width: 17, height: 17, child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
        return Text(AppLocalizations.of(context)!.error({snapshot.error}));
                  } else if (!snapshot.hasData) {
        return Text(AppLocalizations.of(context)!.noData);
                  } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                    'assets/icons/icons8-sunrise-19(-ldpi).png', height: 18,
                    width: 18, color: Colors.white),
                const SizedBox(width: 5,),
                Text(style: const TextStyle(color: Colors.white), DateFormat('hh:mm a').format(
              DateFormat('hh:mm:ss a').parse(snapshot.data!.sunrise))),
              ],
            ),
            Row(
              children: [
                Image.asset(
                    'assets/icons/icons8-sunset-19(-ldpi).png', height: 18,
                    width: 18, color: Colors.white),
                const SizedBox(width: 5,),
                Text(style: const TextStyle(color: Colors.white), DateFormat('hh:mm a').format(
                    DateFormat('hh:mm:ss a').parse(snapshot.data!.sunset)),),
              ],
            ),
          ],
        );
                  }
                },
        ),
      ),
    );
  }
}