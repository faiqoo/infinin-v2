import 'dart:convert';

ExperienceRequest experienceRequestFromJson(String str) =>
    ExperienceRequest.fromJson(json.decode(str));

String experienceRequestToJson(ExperienceRequest data) =>
    json.encode(data.toJson());


class ExperienceRequest {
  T? t;
  int? userId;

  ExperienceRequest({this.t, this.userId});

  ExperienceRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  String? chefAddress;
  String? chefBrandName;
  int? chefId;
  String? chefName;
  int? cityId;
  String? cityName;
  String? description;
  List<ExperienceMedia>? experienceMedia;
  List<ExperiencePreference>? experiencePreferences;
  List<ExperienceWowFactor>? experienceWowFactors;
  int? id;
  int? latitude;
  int? locationId;
  int? longitude;
  int? personMaxLimit;
  String? persons;
  String? placeId;
  int? preferenceId;
  int? price;
  int? priceTypeId;
  String? subHostMobileNo;
  String? subHostName;
  String? title;
  int? townId;
  String? townName;
  int? wowFactorId;

  T(
      {this.chefAddress,
        this.chefBrandName,
        this.chefId,
        this.chefName,
        this.cityId,
        this.cityName,
        this.description,
        this.experienceMedia,
        this.experiencePreferences,
        this.experienceWowFactors,
        this.id,
        this.latitude,
        this.locationId,
        this.longitude,
        this.personMaxLimit,
        this.persons,
        this.placeId,
        this.preferenceId,
        this.price,
        this.priceTypeId,
        this.subHostMobileNo,
        this.subHostName,
        this.title,
        this.townId,
        this.townName,
        this.wowFactorId});

  T.fromJson(Map<String, dynamic> json) {
    chefAddress = json['chefAddress'];
    chefBrandName = json['chefBrandName'];
    chefId = json['chefId'];
    chefName = json['chefName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    description = json['description'];
    if (json['experienceMedia'] != null) {
      experienceMedia = <ExperienceMedia>[];
      json['experienceMedia'].forEach((v) {
        experienceMedia!.add(ExperienceMedia.fromJson(v));
      });
    }
    if (json['experiencePreferences'] != null) {
      experiencePreferences = <ExperiencePreference>[];
      json['experiencePreferences'].forEach((v) {
        experiencePreferences!.add(ExperiencePreference.fromJson(v));
      });
    }
    if (json['experienceWowFactors'] != null) {
      experienceWowFactors = <ExperienceWowFactor>[];
      json['experienceWowFactors'].forEach((v) {
        experienceWowFactors!.add(ExperienceWowFactor.fromJson(v));
      });
    }
    id = json['id'];
    latitude = json['latitude'];
    locationId = json['locationId'];
    longitude = json['longitude'];
    personMaxLimit = json['personMaxLimit'];
    persons = json['persons'];
    placeId = json['placeId'];
    preferenceId = json['preferenceId'];
    price = json['price'];
    priceTypeId = json['priceTypeId'];
    subHostMobileNo = json['subHostMobileNo'];
    subHostName = json['subHostName'];
    title = json['title'];
    townId = json['townId'];
    townName = json['townName'];
    wowFactorId = json['wowFactorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chefAddress'] = chefAddress;
    data['chefBrandName'] = chefBrandName;
    data['chefId'] = chefId;
    data['chefName'] = chefName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['description'] = description;
    if (experienceMedia != null) {
      data['experienceMedia'] =
          experienceMedia!.map((v) => v.toJson()).toList();
    }
    if (experiencePreferences != null) {
      data['experiencePreferences'] =
          experiencePreferences!.map((v) => v.toJson()).toList();
    }
    if (experienceWowFactors != null) {
      data['experienceWowFactors'] =
          experienceWowFactors!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['latitude'] = latitude;
    data['locationId'] = locationId;
    data['longitude'] = longitude;
    data['personMaxLimit'] = personMaxLimit;
    data['persons'] = persons;
    data['placeId'] = placeId;
    data['preferenceId'] = preferenceId;
    data['price'] = price;
    data['priceTypeId'] = priceTypeId;
    data['subHostMobileNo'] = subHostMobileNo;
    data['subHostName'] = subHostName;
    data['title'] = title;
    data['townId'] = townId;
    data['townName'] = townName;
    data['wowFactorId'] = wowFactorId;
    return data;
  }
}

class ExperienceMedia {
  int? experienceId;
  int? id;
  String? mediaUrl;
  String? type;

  ExperienceMedia({this.experienceId, this.id, this.mediaUrl, this.type});

  ExperienceMedia.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    mediaUrl = json['mediaUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['experienceId'] = experienceId;
    data['id'] = id;
    data['mediaUrl'] = mediaUrl;
    data['type'] = type;
    return data;
  }
}

class ExperiencePreference {
  int? experienceId;
  int? id;
  String? preferenceDescription;
  String? preferenceIconPath;
  int? preferenceId;
  String? preferenceName;

  ExperiencePreference(
      {this.experienceId,
        this.id,
        this.preferenceDescription,
        this.preferenceIconPath,
        this.preferenceId,
        this.preferenceName});

  ExperiencePreference.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['experienceId'] = experienceId;
    data['id'] = id;
    data['preferenceDescription'] = preferenceDescription;
    data['preferenceIconPath'] = preferenceIconPath;
    data['preferenceId'] = preferenceId;
    data['preferenceName'] = preferenceName;
    return data;
  }
}

class ExperienceWowFactor {
  int? experienceId;
  int? id;
  String? wowFactorDescription;
  String? wowFactorIconPath;
  int? wowFactorId;
  String? wowFactorName;

  ExperienceWowFactor(
      {this.experienceId,
        this.id,
        this.wowFactorDescription,
        this.wowFactorIconPath,
        this.wowFactorId,
        this.wowFactorName});

  ExperienceWowFactor.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    id = json['id'];
    wowFactorDescription = json['wowFactorDescription'];
    wowFactorIconPath = json['wowFactorIconPath'];
    wowFactorId = json['wowFactorId'];
    wowFactorName = json['wowFactorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['experienceId'] = experienceId;
    data['id'] = id;
    data['wowFactorDescription'] = wowFactorDescription;
    data['wowFactorIconPath'] = wowFactorIconPath;
    data['wowFactorId'] = wowFactorId;
    data['wowFactorName'] = wowFactorName;
    return data;
  }
}