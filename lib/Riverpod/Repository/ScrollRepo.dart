// ignore_for_file: file_names
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../config/my_config.dart';
import '../../helper/constants.dart';
import '../../services/baseDio.dart';

class ScrollRepository {
  Future<String> getScrollNews() async {
    const url = "/api/services/app/SmartPalikaService/GetScrollNotice";
    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      var value = json.decode(response.toString())["result"];
      await setValue(news, value);
      return value;
    } else {
      return "";
    }
  }
}

final scrollController =
    Provider<ScrollRepository>((ref) => ScrollRepository());
final scrollNewsprovider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(scrollController).getScrollNews();
});

class ScrollHive {
  Future<String> getScrollNews() async {
    final String data = getStringAsync(news);
    return data;
  }
}

final scrollHiveController = Provider<ScrollHive>((ref) => ScrollHive());
final scrollHiveprovider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(scrollHiveController).getScrollNews();
});
