import 'package:equatable/equatable.dart';

class QR extends Equatable {
  const QR({
    required this.bookingId,
    required this.chefId,
    required this.foodieId,
    required this.experienceId,
    required this.verificationCode,
  });

  factory QR.fromJson(Map<dynamic, dynamic> json) => QR(
        bookingId: json['bookingId'],
        chefId: json['chefId'],
        foodieId: json['foodieId'],
        experienceId: json['experienceId'] ?? json['tenantId'] ?? '',
        verificationCode: json['verificationCode'],
      );

  factory QR.empty() => const QR(
        bookingId: 0,
        chefId: 0,
        foodieId: 0,
        experienceId: 0,
        verificationCode: 0,
      );

  Map<dynamic, dynamic> toJson() => {
        'bookingId': bookingId,
        'chefId': chefId,
        'foodieId': foodieId,
        'experienceId': experienceId,
        'verificationCode': verificationCode,
      };

  final int bookingId;
  final int chefId;
  final int foodieId;
  final int experienceId;
  final int verificationCode;

  @override
  List<Object?> get props => [
        bookingId,
        chefId,
        foodieId,
        experienceId,
        verificationCode,
      ];
}

class TestQR {
  int? id;
  String? name;
  String? address;

  TestQR({this.id, this.name, this.address});

  TestQR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}
