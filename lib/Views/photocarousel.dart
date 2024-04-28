import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Riverpod/Repository/GalleryRepo.dart';
import '../helper/constants.dart';

class PhotoCarousel extends ConsumerStatefulWidget {
  const PhotoCarousel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends ConsumerState<PhotoCarousel> {
  @override
  Widget build(BuildContext context) {
    final isF = getBoolAsync(isFirst.toString());
    final gallerydata =
        !isF ? ref.watch(galleryProvider) : ref.watch(galleryHiveDataProvider);

    return gallerydata.when(
      data: (data) => CarouselSlider(
          options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1),
          items: List.generate(
              data.length,
              (index) => Container(
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        image: DecorationImage(
                            image: MemoryImage(
                              base64Decode(data[index].photoBytes),
                            ),
                            fit: BoxFit.fill)),
                  ))),
      error: (Object error, StackTrace stackTrace) {
        return const Text("error");
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // data
    //     .map((e) =>
  }
}
