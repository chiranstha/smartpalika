// ignore_for_file: file_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newpalika/Riverpod/Model/wodapatramodel.dart';

import '../../config/my_config.dart';
import '../../services/baseDio.dart';

class WodaPatraRepo {
  Future<List<WodaPatraModel>> getWodaPatra() async {
    const url = "/api/services/app/CmsFrontend/GetAllWadaPatra";

    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> data = map["result"];
      final box = Hive.box<WodaPatraModel>('patras');
      for (var item in data) {
        box.add(WodaPatraModel.fromJson(item));
      }

      return data.map((data) => WodaPatraModel.fromJson(data)).toList();
    } else {
      List<WodaPatraModel> a = [];
      return a;
    }
  }
}

final wodapatraController = Provider<WodaPatraRepo>((ref) => WodaPatraRepo());
final wodapatraProvider =
    FutureProvider.autoDispose<List<WodaPatraModel>>((ref) async {
  return ref.read(wodapatraController).getWodaPatra();
});
