// ignore_for_file: file_names
import 'package:hive_flutter/hive_flutter.dart';
part 'team_model.g.dart';

@HiveType(typeId: 3)
class TeamModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String jobTitle;
  @HiveField(2)
  dynamic shortDescription;
  @HiveField(3)
  dynamic description;
  @HiveField(4)
  String phone;
  @HiveField(5)
  dynamic email;
  @HiveField(6)
  dynamic photo;
  @HiveField(7)
  dynamic photoBytes;
  @HiveField(8)
  dynamic photoFileName;
  @HiveField(9)
  dynamic isPublished;
  @HiveField(10)
  String id;

  TeamModel(
      {required this.name,
      required this.jobTitle,
      required this.shortDescription,
      required this.description,
      required this.phone,
      required this.email,
      this.photo,
      this.photoFileName,
      required this.isPublished,
      required this.id,
      this.photoBytes});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
      name: json["name"],
      jobTitle: json["jobTitle"],
      shortDescription: json["shortDescription"],
      description: json["description"],
      phone: json["phone"],
      email: json["email"],
      photo: json["photo"],
      photoFileName: json["photoFileName"],
      isPublished: json["isPublished"],
      id: json["id"],
      photoBytes: json["photoBytes"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "jobTitle": jobTitle,
        "shortDescription": shortDescription,
        "description": description,
        "phone": phone,
        "email": email,
        "photo": photo,
        "photoFileName": photoFileName,
        "isPublished": isPublished,
        "id": id,
        "photoBytes": photoBytes
      };
}
