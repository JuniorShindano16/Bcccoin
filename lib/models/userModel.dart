import 'package:bcccoin/bd/BdColumnsNames.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phonenumber;

  @HiveField(4)
  String? dateOfBirth;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  String? number;

  @HiveField(7)
  String? avenue;

  @HiveField(8)
  String? quartier;

  @HiveField(9)
  String? commune;

  @HiveField(10)
  String? password;
  @HiveField(11)
  String? bankName;

  UserModel(
      {this.id,
      this.name,
      this.phonenumber,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.commune,
      this.number,
      this.avenue,
      this.quartier,
      this.password,
      this.bankName});

  UserModel.fromJson(Map<String, dynamic> map) {
    id = map[Bdcolumnnames.UserId];
    name = map[Bdcolumnnames.UserName]?.toString();
    password = map[Bdcolumnnames.UserPassword]?.toString();
    email = map[Bdcolumnnames.UserEmail]?.toString();
    phonenumber = map[Bdcolumnnames.UserPhone]?.toString();
    dateOfBirth = map[Bdcolumnnames.UserDateOfBirth]?.toString();
    gender = map[Bdcolumnnames.UserGender]?.toString();
    number = map[Bdcolumnnames.UserNumber]?.toString();
    avenue = map[Bdcolumnnames.UserAvenue]?.toString();
    quartier = map[Bdcolumnnames.UserQuartier]?.toString();
    commune = map[Bdcolumnnames.UserCommune]?.toString();
    bankName = map[Bdcolumnnames.UserBankName]?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      Bdcolumnnames.UserId: id,
      Bdcolumnnames.UserName: name,
      Bdcolumnnames.UserEmail: email,
      Bdcolumnnames.UserPhone: phonenumber,
      Bdcolumnnames.UserDateOfBirth: dateOfBirth,
      Bdcolumnnames.UserGender: gender,
      Bdcolumnnames.UserNumber: number,
      Bdcolumnnames.UserAvenue: avenue,
      Bdcolumnnames.UserQuartier: quartier,
      Bdcolumnnames.UserCommune: commune,
      Bdcolumnnames.UserPassword: password,
      Bdcolumnnames.UserBankName: bankName
    };
  }
}
