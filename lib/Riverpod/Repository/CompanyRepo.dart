// ignore_for_file: file_names

import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../config/my_config.dart';
import '../../helper/constants.dart';
import '../../services/baseDio.dart';

class CompanyInfo {
  Future<String> getCompanyInfo() async {
    const url = "/api/services/app/SmartPalikaService/GetCompanyInfo";
    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      var value =
          json.decode(response.toString())["result"]["wardNo"].toString();
      await setValue(companyInfo, value);
      return value;
    } else {
      return "";
    }
  }
}

final wardController = Provider<CompanyInfo>((ref) => CompanyInfo());
final wardprovider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(wardController).getCompanyInfo();
});

class WardRepo {
  Future<String> getWardNumber() async {
    final String data = getStringAsync(companyInfo);
    return data;
  }
}

final wardRepoController = Provider<WardRepo>((ref) => WardRepo());
final wardHiveProvider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(wardRepoController).getWardNumber();
});
