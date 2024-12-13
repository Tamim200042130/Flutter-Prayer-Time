import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time_flutter/features/home_page/PrayerCardSettingsPage.dart';
import 'package:prayer_time_flutter/widgets/app_card.dart';
import '../../../../constants/size_constants.dart';
import '../constants/color_constants.dart';

class PrayerTimesCard extends StatefulWidget {
  final PrayerTimes prayerTimes;

  const PrayerTimesCard({super.key, required this.prayerTimes});

  @override
  State<PrayerTimesCard> createState() => _PrayerTimesCardState();
}

class _PrayerTimesCardState extends State<PrayerTimesCard> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ongoingPrayer = getOngoingPrayer(widget.prayerTimes);
    final nextPrayer = getNextPrayer(widget.prayerTimes);

    DateTime? displayTime;
    Widget message;

    if (ongoingPrayer != null) {
      displayTime = ongoingPrayer.endTime;
      message = Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: ongoingPrayer.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: '\nwill end '),
          ],
        ),
      );
    } else {
      displayTime = nextPrayer.startTime;
      message = Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: nextPrayer.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: '\nwill start'),
          ],
        ),
      );
    }

    return Stack(
      children: [
        AppCard(
          padding: SizeConstants.small,
          marginH: SizeConstants.tiny,
          marginV: SizeConstants.tiny,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    message,
                    const SizedBox(height: 8),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double size = constraints.maxWidth * 0.7;
                        double strokeWidth = size * 0.1;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: size,
                              height: size,
                              child: CircularProgressIndicator(
                                strokeWidth: strokeWidth,
                                value: calculateProgress(
                                    ongoingPrayer?.startTime ??
                                        nextPrayer.startTime,
                                    displayTime),
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    ColorConstants.primary),
                              ),
                            ),
                            Text(
                              formatCountdown(displayTime),
                              style: TextStyle(
                                  fontSize: size * 0.16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPrayerTimeRow('Fajr', widget.prayerTimes.fajr,
                        widget.prayerTimes.sunrise),
                    const Divider(),
                    buildPrayerTimeRow('Dhuhr', widget.prayerTimes.dhuhr,
                        widget.prayerTimes.asr),
                    const Divider(),
                    buildPrayerTimeRow('Asr', widget.prayerTimes.asr,
                        widget.prayerTimes.maghrib),
                    const Divider(),
                    buildPrayerTimeRow('Maghrib', widget.prayerTimes.maghrib,
                        widget.prayerTimes.isha),
                    const Divider(),
                    buildPrayerTimeRow('Isha', widget.prayerTimes.isha,
                        widget.prayerTimes.fajr.add(const Duration(days: 1))),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 5,
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrayerCardSettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPrayerTimeRow(
      String prayerName, DateTime? startTime, DateTime? endTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            '${formatTime(startTime)} - ${formatTime(endTime)}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Prayer? getOngoingPrayer(PrayerTimes prayerTimes) {
    final now = DateTime.now();
    if (now.isAfter(prayerTimes.fajr) && now.isBefore(prayerTimes.sunrise)) {
      return Prayer('Fajr', prayerTimes.fajr, prayerTimes.sunrise);
    } else if (now.isAfter(prayerTimes.dhuhr) &&
        now.isBefore(prayerTimes.asr)) {
      return Prayer('Dhuhr', prayerTimes.dhuhr, prayerTimes.asr);
    } else if (now.isAfter(prayerTimes.asr) &&
        now.isBefore(prayerTimes.maghrib)) {
      return Prayer('Asr', prayerTimes.asr, prayerTimes.maghrib);
    } else if (now.isAfter(prayerTimes.maghrib) &&
        now.isBefore(prayerTimes.isha)) {
      return Prayer('Maghrib', prayerTimes.maghrib, prayerTimes.isha);
    } else if (now.isAfter(prayerTimes.isha)) {
      return Prayer('Isha', prayerTimes.isha,
          prayerTimes.fajr.add(const Duration(days: 1)));
    }
    return null;
  }

  Prayer getNextPrayer(PrayerTimes prayerTimes) {
    final now = DateTime.now();
    if (now.isBefore(prayerTimes.fajr)) {
      return Prayer('Fajr', prayerTimes.fajr, prayerTimes.sunrise);
    } else if (now.isBefore(prayerTimes.dhuhr)) {
      return Prayer('Dhuhr', prayerTimes.dhuhr, prayerTimes.asr);
    } else if (now.isBefore(prayerTimes.asr)) {
      return Prayer('Asr', prayerTimes.asr, prayerTimes.maghrib);
    } else if (now.isBefore(prayerTimes.maghrib)) {
      return Prayer('Maghrib', prayerTimes.maghrib, prayerTimes.isha);
    } else {
      return Prayer('Isha', prayerTimes.isha,
          prayerTimes.fajr.add(const Duration(days: 1)));
    }
  }

  double calculateProgress(DateTime? startTime, DateTime? endTime) {
    if (startTime == null || endTime == null) return 0.0;
    final totalDuration = endTime.difference(startTime).inSeconds;
    final elapsedDuration = DateTime.now().difference(startTime).inSeconds;
    return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
  }

  String formatTime(DateTime? time) {
    if (time == null) return 'N/A';
    return DateFormat('h:mm').format(time);
  }

  String formatCountdown(DateTime? endTime) {
    if (endTime == null) return 'N/A';
    final now = DateTime.now();
    final remaining = endTime.difference(now);
    if (remaining.isNegative) return '00:00:00';
    final hours = remaining.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes =
        remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}

class Prayer {
  final String name;
  final DateTime startTime;
  final DateTime endTime;

  Prayer(this.name, this.startTime, this.endTime);
}
