class DataRequest {
  DataRequest({
    required this.t,
  });

  T t;

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
        t: T.fromJson(json["t"]),
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
      };
}

// class T {
//   T({
//     this.age,
//     this.gender,
//     this.mobileNo,
//     this.name,
//     this.professionalId,
//     this.profileImageUrl,
//     this.brandName,
//     this.address,
//     this.cityId,
//   });
//
//   String? age;
//   String? gender;
//   String? mobileNo;
//   String? brandName;
//   String? name;
//   String? address;
//   int? professionalId;
//   String? profileImageUrl;
//   int? cityId;
//
//   factory T.fromJson(Map<String, dynamic> json) => T(
//         age: json["age"],
//         gender: json["gender"],
//         mobileNo: json["mobileNo"],
//         name: json["name"],
//         professionalId: json["professionalId"],
//         profileImageUrl: json["profileImageUrl"],
//         brandName: json["brandName"],
//         address: json["address"],
//         cityId: json["cityId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "age": age,
//         "gender": gender,
//         "mobileNo": mobileNo,
//         "name": name,
//         "professionalId": professionalId,
//         "profileImageUrl": profileImageUrl,
//         "brandName": brandName,
//         "address": address,
//         "cityId": cityId,
//       };
// }
class T {
  String? address;
  String? brandName;
  int? cityId;
  String? cityName;
  String? facebook;
  int? id;
  String? instagram;
  int? latitude;
  int? longitude;
  String? mobileNo;
  String? name;
  String? placeId;
  String? tiktok;
  int? townId;
  String? townName;
  String? twitter;
  String? status;
  int? chefId;

  T({
    this.address,
    this.brandName,
    this.cityId,
    this.cityName,
    this.facebook,
    this.id,
    this.instagram,
    this.latitude,
    this.longitude,
    this.mobileNo,
    this.name,
    this.placeId,
    this.tiktok,
    this.townId,
    this.townName,
    this.twitter,
    this.status,
    this.chefId,
  });

  factory T.fromJson(Map<String, dynamic> json) => T(
        address: json["address"],
        brandName: json["brandName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        facebook: json["facebook"],
        id: json["id"],
        instagram: json["instagram"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        mobileNo: json["mobileNo"],
        name: json["name"],
        placeId: json["placeId"],
        tiktok: json["tiktok"],
        townId: json["townId"],
        townName: json["townName"],
        twitter: json["twitter"],
        status: json["status"],
        chefId: json["chefId"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "brandName": brandName,
        "cityId": cityId,
        "cityName": cityName,
        "facebook": facebook,
        "id": id,
        "instagram": instagram,
        "latitude": latitude,
        "longitude": longitude,
        "mobileNo": mobileNo,
        "name": name,
        "placeId": placeId,
        "tiktok": tiktok,
        "townId": townId,
        "townName": townName,
        "twitter": twitter,
        "status": status,
        "chefId": chefId,
      };
}
