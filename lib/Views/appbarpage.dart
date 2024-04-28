import 'dart:async';
import 'package:nb_utils/nb_utils.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marquee/marquee.dart' as mq;
import 'package:newpalika/Riverpod/Repository/CompanyRepo.dart';
import 'package:newpalika/helper/constants.dart';
import '../Riverpod/Repository/ScrollRepo.dart';

import 'package:intl/intl.dart';

class AppBarPage extends ConsumerStatefulWidget {
  final Widget child;
  const AppBarPage({super.key, required this.child});

  @override
  ConsumerState<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends ConsumerState<AppBarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isF = getBoolAsync(isFirst.toString());
    final wardDetails =
        !isF ? ref.watch(wardprovider) : ref.watch(wardHiveProvider);

    final details =
        !isF ? ref.watch(scrollNewsprovider) : ref.watch(scrollHiveprovider);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        toolbarHeight: MediaQuery.sizeOf(context).width * 0.09,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/governmentlogo.svg',
              height: 70,
              width: 80,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "बर्जु गाउँपालिका, गाउँ कार्यपालिकाको कार्यालय ",
                  style: TextStyle(fontSize: 30),
                ),
                wardDetails.when(
                  data: (data) => Text(
                    "${NepaliUnicode.convert(data)} नं वडा कार्यालय",
                    style: const TextStyle(fontSize: 18),
                  ),
                  error: (Object error, StackTrace stackTrace) {
                    return Container();
                  },
                  loading: () {
                    return Container();
                  },
                ),
                const Text(
                  "अमाहिवेल्हा, सुनसरी, कोशी प्रदेश, नेपाल ",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      NepaliDateFormat.MMMMEEEEd(Language.nepali)
                          .format(NepaliDateTime.now()),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Text(
                          NepaliUnicode.convert(
                              DateFormat('hh:mm').format(DateTime.now())),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/nepalflag.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: widget.child),
          details.when(
            data: (data) => data.isEmpty
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      color: Colors.red,
                      child: mq.Marquee(
                        text: data,

                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 30.0,

                        // pauseAfterRound: Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                  ),
            error: (Object error, StackTrace stackTrace) {
              return Container();
            },
            loading: () {
              return Container();
            },
          )
        ],
      ),
    );
  }
}

class DateState extends ChangeNotifier {
  DateTime currentDate = DateTime.now();

  changeDate(DateTime date) {
    currentDate = date;
    notifyListeners();
  }

  DateTime get getDate => currentDate;
}

final dateProvider = ChangeNotifierProvider<DateState>((ref) => DateState());
