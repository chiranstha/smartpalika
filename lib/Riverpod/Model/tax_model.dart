import 'package:hive_flutter/hive_flutter.dart';
import 'package:newpalika/Riverpod/Model/tax_details_model.dart';
part 'tax_model.g.dart';

@HiveType(typeId: 0)
class TaxModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Detail> details;

  TaxModel({
    required this.name,
    required this.details,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) => TaxModel(
        name: json["name"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}
