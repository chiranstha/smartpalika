// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';
part 'gallery_model.g.dart';

@HiveType(typeId: 4)
class GalleryList extends HiveObject {
  @HiveField(0)
  String photoBytes;
  @HiveField(1)
  String title;
  @HiveField(2)
  String id;
  @HiveField(3)
  String description;

  GalleryList({
    required this.photoBytes,
    required this.title,
    required this.id,
    required this.description,
  });

  factory GalleryList.fromJson(Map<String, dynamic> json) => GalleryList(
        photoBytes: json["photoBytes"],
        title: json["title"],
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "photoBytes": photoBytes,
        "title": title,
        "id": id,
        "description": description,
      };
}
