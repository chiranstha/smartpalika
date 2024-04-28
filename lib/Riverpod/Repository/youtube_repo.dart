import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../config/my_config.dart';
import '../../services/baseDio.dart';
import '../Model/youtube_model.dart';

class YoutubeRepository {
  Future<List<YoutubeModel>> getyoutubeVideos() async {
    const url = "/api/services/app/YoutubeLinks/GetAll";

    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> data = map["result"]["items"];

      final box = Hive.box<YoutubeModel>('videos');
      for (var item in data) {
        box.add(YoutubeModel.fromJson(item));
      }

      return data.map((data) => YoutubeModel.fromJson(data)).toList();
    } else {
      List<YoutubeModel> a = [];
      return a;
    }
  }
}

final youtubeProvider =
    Provider<YoutubeRepository>((ref) => YoutubeRepository());

class YoutubeHiveController {
  Future<List<YoutubeModel>> getyoutubeVideos() async {
    final box = Hive.box<YoutubeModel>('videos').values.toList();

    return box;
  }
}

final youtubeHiveProvider =
    Provider<YoutubeHiveController>((ref) => YoutubeHiveController());
