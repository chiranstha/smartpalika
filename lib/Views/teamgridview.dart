// ignore_for_file: deprecated_member_use, must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Riverpod/Model/team_model.dart';

class TeamGridViewPage extends ConsumerStatefulWidget {
  Future<List<TeamModel>> dat;
  TeamGridViewPage({super.key, required this.dat});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TeamGridViewPageState();
}

class _TeamGridViewPageState extends ConsumerState<TeamGridViewPage> {
  List<TeamModel> data = [];

  getdata() {
    widget.dat.then((value) {
      setState(() {
        final data1 = value[1];
        final data2 = value[2];
        data.add(data1);
        data.add(data2);
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // maxCrossAxisExtent: 300,
        crossAxisCount: 2,
        mainAxisExtent: 270,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data[index].photoBytes == null
                      ? SizedBox(
                          height: 60,
                          width: 80,
                          child: SvgPicture.asset(
                            "assets/images/person.svg",
                            fit: BoxFit.fill,
                            color: Colors.grey.shade600,
                          ))
                      : Container(
                          height: 60,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(data[index].photoBytes)),
                                  fit: BoxFit.cover)),
                        ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          data[index].jobTitle,
                          style: const TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          data[index].phone,
                          style: const TextStyle(
                              fontSize: 12,
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
