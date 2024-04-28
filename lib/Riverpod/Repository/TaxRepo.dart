// ignore_for_file: file_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newpalika/Riverpod/Model/tax_model.dart';

import '../../config/my_config.dart';
import '../../services/baseDio.dart';

class TaxRepo {
  Future<List<TaxModel>> getTaxRules() async {
    const url = "/api/services/app/CmsFrontend/GetAllTaxRule";

    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> data = map["result"];
      final box = Hive.box<TaxModel>('taxs');
      for (var item in data) {
        box.add(TaxModel.fromJson(item));
      }

      return data.map((data) => TaxModel.fromJson(data)).toList();
    } else {
      List<TaxModel> a = [];
      return a;
    }
  }
}

final taxController = Provider<TaxRepo>((ref) => TaxRepo());
final taxProvider = FutureProvider.autoDispose<List<TaxModel>>((ref) async {
  return ref.read(taxController).getTaxRules();
});
