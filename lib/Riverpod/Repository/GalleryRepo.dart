// ignore_for_file: file_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newpalika/Riverpod/Model/gallery_model.dart';

import '../../config/my_config.dart';
import '../../services/baseDio.dart';

class GalleryRepo {
  Future<List<GalleryList>> getGallery() async {
    const url = "/api/services/app/CmsFrontend/GetGalleryPage";

    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> data = map["result"]["galleryList"];
      final box = Hive.box<GalleryList>('photos');
      for (var item in data) {
        box.add(GalleryList.fromJson(item));
      }

      return data.map((data) => GalleryList.fromJson(data)).toList();
    } else {
      List<GalleryList> a = [];
      return a;
    }
  }
}

final galleryController = Provider<GalleryRepo>((ref) => GalleryRepo());

final galleryProvider =
    FutureProvider.autoDispose<List<GalleryList>>((ref) async {
  return ref.read(galleryController).getGallery();
});

class GalleryHiveProvider {
  Future<List<GalleryList>> getGallery() async {
    final box = Hive.box<GalleryList>('photos').values.toList();

    return box;
  }
}

final hiveGalleryController =
    Provider<GalleryHiveProvider>((ref) => GalleryHiveProvider());

final galleryHiveDataProvider =
    FutureProvider.autoDispose<List<GalleryList>>((ref) async {
  return ref.read(hiveGalleryController).getGallery();
});
