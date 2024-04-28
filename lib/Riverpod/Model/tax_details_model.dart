import 'package:hive_flutter/hive_flutter.dart';
part 'tax_details_model.g.dart';

@HiveType(typeId: 1)
class Detail extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String rate;

  Detail({
    required this.name,
    required this.description,
    required this.rate,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        name: json["name"],
        description: json["description"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "rate": rate,
      };
}
