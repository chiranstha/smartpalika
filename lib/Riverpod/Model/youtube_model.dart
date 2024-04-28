import 'package:hive_flutter/hive_flutter.dart';
part 'youtube_model.g.dart';

@HiveType(typeId: 5)
class YoutubeModel extends HiveObject {
  @HiveField(0)
  String link;
  @HiveField(1)
  String name;
  @HiveField(2)
  String createDate;
  @HiveField(3)
  String expiryDate;
  @HiveField(4)
  String id;

  YoutubeModel({
    required this.link,
    required this.name,
    required this.createDate,
    required this.expiryDate,
    required this.id,
  });

  factory YoutubeModel.fromJson(Map<String, dynamic> json) => YoutubeModel(
        link: json["link"],
        name: json["name"],
        createDate: json["createDate"],
        expiryDate: json["expiryDate"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "name": name,
        "createDate": createDate,
        "expiryDate": expiryDate,
        "id": id,
      };
}
