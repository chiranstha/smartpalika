// ignore_for_file: deprecated_member_use, must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Riverpod/Model/team_model.dart';

class TeamHomePage extends ConsumerStatefulWidget {
  Future<List<TeamModel>> dat;
  int firstValue;

  TeamHomePage({
    super.key,
    required this.dat,
    required this.firstValue,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamHomePageState();
}

class _TeamHomePageState extends ConsumerState<TeamHomePage> {
  List<TeamModel> data = [];

  getdata() {
    widget.dat.then((value) {
      setState(() {
        final data1 = value[widget.firstValue];

        data.add(data1);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  data[index].photoBytes == null
                      ? SizedBox(
                          height: 40,
                          width: 60,
                          child: SvgPicture.asset(
                            "assets/images/person.svg",
                            fit: BoxFit.fill,
                            color: Colors.grey.shade600,
                          ))
                      : Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(data[index].photoBytes)),
                                  fit: BoxFit.cover)),
                        ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].name,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          data[index].jobTitle,
                          style: const TextStyle(
                              fontSize: 11,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          data[index].phone,
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
        );
      },
    );
  }
}
