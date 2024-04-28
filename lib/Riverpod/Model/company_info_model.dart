class CompanyInfoModel {
  String name;
  String address;
  String email;
  String phone;
  dynamic logo;
  String facebook;
  String twitter;
  String youtube;
  String aboutUs;
  String description;
  String id;

  CompanyInfoModel({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.logo,
    required this.facebook,
    required this.twitter,
    required this.youtube,
    required this.aboutUs,
    required this.description,
    required this.id,
  });

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) =>
      CompanyInfoModel(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        youtube: json["youtube"],
        aboutUs: json["aboutUs"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "phone": phone,
        "logo": logo,
        "facebook": facebook,
        "twitter": twitter,
        "youtube": youtube,
        "aboutUs": aboutUs,
        "description": description,
        "id": id,
      };
}
