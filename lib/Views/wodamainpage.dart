import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:newpalika/Riverpod/Model/tax_model.dart';
import 'package:newpalika/Riverpod/Model/wodapatramodel.dart';
import 'package:newpalika/Riverpod/Repository/WodaPatraRepo.dart';
import 'package:newpalika/Views/appbarpage.dart';
import 'package:newpalika/Views/homememberspage.dart';
import 'package:newpalika/Views/photocarousel.dart';
import 'package:newpalika/Views/teamhomepage.dart';
import 'package:newpalika/Views/wodapatrapage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Riverpod/Model/youtube_model.dart';
import '../Riverpod/Repository/TaxRepo.dart';
import '../Riverpod/Repository/TeamMemberRepo.dart';
import '../Riverpod/Repository/youtube_repo.dart';
import '../Widgets/constants.dart';
import '../helper/constants.dart';

class WodaPage extends ConsumerStatefulWidget {
  const WodaPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WodaPageState();
}

class _WodaPageState extends ConsumerState<WodaPage>
    with TickerProviderStateMixin {
  final CarouselController scontroller = CarouselController();
  late PageController pageController;
  late TabController tabController;
  List<YoutubeModel>? videoUrls;
  List<WodaPatraModel>? wodaPatraList;
  List<TaxModel>? taxList;

  Future<List<YoutubeModel>> getVideos() async {
    final isF = getBoolAsync(isFirst.toString());
    final details = !isF
        ? await ref.read(youtubeProvider).getyoutubeVideos()
        : await ref.read(youtubeHiveProvider).getyoutubeVideos();
    if (mounted) {
      setState(() {
        videoUrls = details;
      });
    }

    return details;
  }

  int currentPage = 0;
  ScrollController rajController = ScrollController();
  initdata() async {
    bool isF = getBoolAsync(isFirst.toString());
    final patraData = Hive.box<WodaPatraModel>('patras').values.toList();
    final taxData = Hive.box<TaxModel>('taxs').values.toList();
    final details =
        !isF ? await ref.read(wodapatraController).getWodaPatra() : patraData;
    final taxdata =
        !isF ? await ref.read(taxController).getTaxRules() : taxData;
    if (mounted) {
      setState(() {
        wodaPatraList = details;
        taxList = taxdata;
      });
    }
  }

  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      if (currentPage == wodaPatraList!.length - 1) {
        currentPage = 0;
      } else {
        currentPage++;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    getVideos();
    tabController = TabController(length: 2, vsync: this);
    pageController = PageController(
      initialPage: currentPage,
    );

    initdata().then((value) =>
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          startAutoScroll();
          await setValue(isFirst.toString(), true);

          double minScrollExtent2 = rajController.position.minScrollExtent;
          double maxScrollExtent2 = rajController.position.maxScrollExtent;

          animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2,
              1200, rajController);
        }));
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  void dispose() {
    // patraController.dispose();
    rajController.dispose();
    pageController.dispose();
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isF = getBoolAsync(isFirst.toString());
    return AppBarPage(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 8.0, bottom: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "सेवाहरू",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800),
                  ),
                  IgnorePointer(
                    child: Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            wodaPatraList == null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ExpandablePageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    //make co
                                    controller: pageController,
                                    itemCount: wodaPatraList!.length,
                                    itemBuilder: (context, index) {
                                      return wodapatramaker(
                                          wodaPatraList![index]);
                                    }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "राजस्व दर",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800),
                  ),
                  IgnorePointer(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      child: taxList == null
                          ? const Center(child: CircularProgressIndicator())
                          : taxList!.isEmpty
                              ? const Center(child: Text('No Data Found'))
                              : ListView.builder(
                                  // shrinkWrap: true,
                                  controller: rajController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: taxList!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            taxList![index].name,
                                            style: boldtextStyle(Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                            shrinkWrap: true,
                                            itemCount:
                                                taxList![index].details.length,
                                            itemBuilder: (context, dindex) =>
                                                Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      taxList![index]
                                                          .details[dindex]
                                                          .name,
                                                      style: simpletextStyle(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      taxList![index]
                                                          .details[dindex]
                                                          .rate
                                                          .toString(),
                                                      style: ratetextStyle(
                                                          Colors.black),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                ),
                    ),
                  ),
                  TeamHomePage(
                    dat: !isF
                        ? ref.read(teamMembersController).getWodaMain()
                        : ref.read(teamHiveProvider).getWodaMain(),
                    firstValue: 5,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(height: 200, color: Colors.red),
                  SizedBox(
                    height: 40,
                    child: TabBar(
                      unselectedLabelStyle: const TextStyle(fontSize: 16),
                      labelStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.red.shade800,
                      indicatorColor: Colors.red.shade800,
                      controller: tabController,
                      tabs: const [
                        Text('फोटो'),
                        Text('भिडियो'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  videoUrls == null
                      ? const Center(child: CircularProgressIndicator())
                      : IgnorePointer(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                const PhotoCarousel(),
                                CarouselSlider(
                                  carouselController: scontroller,
                                  items: videoUrls!.map((e) {
                                    YoutubePlayerController ycontroller =
                                        YoutubePlayerController(
                                      initialVideoId:
                                          YoutubePlayer.convertUrlToId(e.link
                                                      .startsWith('H')
                                                  ? "https:${e.link.split(':')[1]}"
                                                  : e.link)
                                              .toString(),
                                      flags: const YoutubePlayerFlags(
                                          autoPlay: true,
                                          mute: false,
                                          loop: true,
                                          hideThumbnail: true,
                                          useHybridComposition: true,
                                          forceHD: true,
                                          disableDragSeek: true),
                                    );
                                    return YoutubePlayer(
                                      controller: ycontroller,
                                      liveUIColor: Colors.amber,
                                    )..controller.addListener(() {
                                        if (ycontroller.value.playerState ==
                                            PlayerState.ended) {
                                          scontroller.nextPage();
                                        }
                                      });
                                  }).toList(),
                                  options: CarouselOptions(
                                      aspectRatio: 16 / 9,
                                      enlargeCenterPage: false,
                                      enableInfiniteScroll: true,
                                      initialPage: 0,
                                      autoPlay: false,
                                      viewportFraction: 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "जनप्रतिनिधि",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800),
                  ),

                  const IgnorePointer(child: HomeMembersPage()),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
