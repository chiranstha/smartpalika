import 'package:flutter/material.dart';
import 'package:newpalika/Riverpod/Model/wodapatramodel.dart';

import '../Widgets/constants.dart';

wodapatramaker(WodaPatraModel wodaData) {
  return Container(
      // color: Colors.red,
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          wodaData.serviceName,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 2,
        ),
        Text("आवश्यक पर्ने कागजातहरु", style: mediumtextStyle(Colors.blue)),
        const SizedBox(
          height: 2,
        ),
        Text(
          wodaData.requiredDocument,
          style: simpletextStyle(),
        ),
        const SizedBox(
          height: 2,
        ),
        Text("सेवा सुविधा प्राप्त गर्न आवश्यक पर्ने प्रक्रिया",
            style: mediumtextStyle(Colors.blue)),
        const SizedBox(
          height: 2,
        ),
        Text(
          wodaData.importDocument,
          style: simpletextStyle(),
        ),
        const Divider(),
        Text(
          "जिम्मेवार अधिकारी: ${wodaData.responsiblePerson}",
          style: ratetextStyle(Colors.black),
        ),
        const Divider(),
        Text(
          "लाग्ने दस्तुर: ${wodaData.rate}",
          style: ratetextStyle(Colors.black),
        ),
        const Divider(),
        Text(
          "लाग्ने समय: ${wodaData.time}",
          style: ratetextStyle(Colors.black),
        ),
      ]));
}
