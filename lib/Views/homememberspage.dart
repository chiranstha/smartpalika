// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:newpalika/Views/teamhomepage.dart';

import '../Riverpod/Repository/TeamMemberRepo.dart';
import '../helper/constants.dart';

class HomeMembersPage extends ConsumerStatefulWidget {
  const HomeMembersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMembersPageState();
}

class _HomeMembersPageState extends ConsumerState<HomeMembersPage> {
  @override
  Widget build(BuildContext context) {
    final isF = getBoolAsync(isFirst.toString());
    final employee =
        !isF ? ref.watch(wodaMainProvider) : ref.watch(teamHiveDataProvider);
    return employee.when(data: (data) {
      return data.isEmpty
          ? const Center(child: Text('No Data Found'))
          : Column(
              children: [
                SizedBox(
                  width: 180,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        data[0].photoBytes == null
                            ? SizedBox(
                                height: 40,
                                width: 50,
                                child: SvgPicture.asset(
                                  "assets/images/person.svg",
                                  fit: BoxFit.fill,
                                  color: Colors.grey.shade600,
                                ))
                            : Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: MemoryImage(
                                            base64Decode(data[0].photoBytes)),
                                        fit: BoxFit.fill)),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                // data[index].name,
                                data[0].name,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                data[0].jobTitle,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                data[0].phone,
                                style: const TextStyle(
                                    fontSize: 11,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TeamHomePage(
                    firstValue: 3,
                    dat: !isF
                        ? ref.read(teamMembersController).getWodaMain()
                        : ref.read(teamHiveProvider).getWodaMain()),
                TeamHomePage(
                    firstValue: 4,
                    dat: !isF
                        ? ref.read(teamMembersController).getWodaMain()
                        : ref.read(teamHiveProvider).getWodaMain()),
                TeamHomePage(
                  dat: !isF
                      ? ref.read(teamMembersController).getWodaMain()
                      : ref.read(teamHiveProvider).getWodaMain(),
                  firstValue: 1,
                ),
                TeamHomePage(
                  dat: !isF
                      ? ref.read(teamMembersController).getWodaMain()
                      : ref.read(teamHiveProvider).getWodaMain(),
                  firstValue: 2,
                ),
              ],
            );
    }, error: (Object error, StackTrace stackTrace) {
      return Center(child: Text('Error: $error'));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
