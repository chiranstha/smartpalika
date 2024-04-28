// ignore_for_file: file_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/my_config.dart';
import '../../services/baseDio.dart';
import '../Model/team_model.dart';

class TeamMemberRepository {
  Future<List<TeamModel>> getWodaMain() async {
    const url = "/api/services/app/CmsFrontend/GetAllWadaRepresentative";

    final response = await Api().get(
      MyConfig.appUrl + url,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.data);
      List<dynamic> data = map["result"];
      final box = Hive.box<TeamModel>('members');
      for (var item in data) {
        box.add(TeamModel.fromJson(item));
      }

      return data.map((data) => TeamModel.fromJson(data)).toList();
    } else {
      List<TeamModel> a = [];
      return a;
    }
  }
}

final teamMembersController =
    Provider<TeamMemberRepository>((ref) => TeamMemberRepository());

final wodaMainProvider =
    FutureProvider.autoDispose<List<TeamModel>>((ref) async {
  return ref.read(teamMembersController).getWodaMain();
});

class TeamHiveController {
  Future<List<TeamModel>> getWodaMain() async {
    final box = Hive.box<TeamModel>('members').values.toList();

    return box;
  }
}

final teamHiveProvider =
    Provider<TeamHiveController>((ref) => TeamHiveController());

final teamHiveDataProvider =
    FutureProvider.autoDispose<List<TeamModel>>((ref) async {
  return ref.read(teamHiveProvider).getWodaMain();
});
