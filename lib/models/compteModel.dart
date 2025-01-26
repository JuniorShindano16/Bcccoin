import 'package:bcccoin/bd/BdColumnsNames.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

@HiveType(typeId: 2) // Assurez-vous que le typeId est unique
class CompteModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? devise;

  @HiveField(2)
  String? name;

  @HiveField(3)
  double? solde;

  @HiveField(4)
  UserModel? userModel;

  // Constructeur
  CompteModel({
    this.id,
    this.devise,
    this.name,
    this.solde,
    this.userModel,
  });

  CompteModel.fromJson(Map<String, dynamic> map) {
    id = map[Bdcolumnnames.CompteId];
    devise = map[Bdcolumnnames.CompteDevise]?.toString();
    name = map[Bdcolumnnames.CompteName]?.toString();
    solde = map[Bdcolumnnames.CompteSolde] != null
        ? double.tryParse(map[Bdcolumnnames.CompteSolde].toString())
        : null;
    userModel = map[Bdcolumnnames
        .CompteUserId]; 
  }

  // Méthode pour convertir une instance de CompteModel en Map JSON
  Map<String, dynamic> toJson() {
    return {
      Bdcolumnnames.CompteId: id,
      Bdcolumnnames.CompteDevise: devise,
      Bdcolumnnames.CompteName: name,
      Bdcolumnnames.CompteSolde: solde,
      Bdcolumnnames.CompteUserId:
          userModel, 
    };
  }
}
