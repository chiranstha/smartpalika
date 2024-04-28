import 'package:hive_flutter/hive_flutter.dart';
part 'wodapatramodel.g.dart';

@HiveType(typeId: 2)
class WodaPatraModel extends HiveObject {
  @HiveField(0)
  String serviceName;
  @HiveField(1)
  String importDocument;
  @HiveField(2)
  String requiredDocument;
  @HiveField(3)
  String responsiblePerson;
  @HiveField(4)
  String rate;
  @HiveField(5)
  String time;
  @HiveField(6)
  String remark;
  @HiveField(7)
  int order;
  @HiveField(8)
  String id;

  WodaPatraModel({
    required this.serviceName,
    required this.importDocument,
    required this.requiredDocument,
    required this.responsiblePerson,
    required this.rate,
    required this.time,
    required this.remark,
    required this.order,
    required this.id,
  });

  factory WodaPatraModel.fromJson(Map<String, dynamic> json) => WodaPatraModel(
        serviceName: json["serviceName"],
        importDocument: json["importDocument"],
        requiredDocument: json["requiredDocument"],
        responsiblePerson: json["responsiblePerson"],
        rate: json["rate"],
        time: json["time"],
        remark: json["remark"],
        order: json["order"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "importDocument": importDocument,
        "requiredDocument": requiredDocument,
        "responsiblePerson": responsiblePerson,
        "rate": rate,
        "time": time,
        "remark": remark,
        "order": order,
        "id": id,
      };
}
