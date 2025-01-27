import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:bcccoin/bd/BdColumnsNames.dart';

@HiveType(typeId: 3)
class TransactionCompteModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? compteSourceId;

  @HiveField(2)
  String? compteDestinationId;

  @HiveField(3)
  double? montantTransaction;

  @HiveField(4)
  double? soldeSourceAvant;

  @HiveField(5)
  double? soldeDestinationAvant;

  @HiveField(6)
  double? soldeSource;

  @HiveField(7)
  double? soldeDestination;

  @HiveField(8)
  double? taux;

  @HiveField(9)
  DateTime? date;

  @HiveField(10)
  String? idAgent;
  @HiveField(11)
  String? libele;
  @HiveField(12)
  String? service;
  @HiveField(13)
  String? proprietaire;

  TransactionCompteModel(
      {this.id,
      this.compteSourceId,
      this.compteDestinationId,
      this.montantTransaction,
      this.soldeSourceAvant,
      this.soldeDestinationAvant,
      this.soldeSource,
      this.soldeDestination,
      this.taux,
      this.date,
      this.idAgent,
      this.libele,
      this.service,
      this.proprietaire});

  TransactionCompteModel.fromJson(Map<String, dynamic> map) {
    id = map[Bdcolumnnames.TransactionCompteId];
    compteSourceId = map[Bdcolumnnames.TransactionCompteSource];
    compteDestinationId = map[Bdcolumnnames.TransactionCompteDestination];
    montantTransaction =
        map[Bdcolumnnames.TransactionCompteMontantTransactions]?.toDouble();
    soldeSourceAvant =
        map[Bdcolumnnames.TransactionCompteSoldeSourceAvant]?.toDouble();
    soldeDestinationAvant =
        map[Bdcolumnnames.TransactionCompteSoldeDestinationAvant]?.toDouble();
    soldeSource = map[Bdcolumnnames.TransactionCompteSoldeSource]?.toDouble();
    soldeDestination =
        map[Bdcolumnnames.TransactionCompteSoldeDestination]?.toDouble();
    taux = map[Bdcolumnnames.TransactionCompteTaux]?.toDouble();
    date = DateTime.tryParse(
        map[Bdcolumnnames.TransactionCompteDate]?.toString() ?? '');
    idAgent = map[Bdcolumnnames.TransactionCompteidAgent]?.toString();
    libele = map[Bdcolumnnames.TransactionCompteLibele]?.toString();
    service = map[Bdcolumnnames.TransactionCompteService]?.toString();
    proprietaire = map[Bdcolumnnames.TransactionCompteproprietaire]?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      Bdcolumnnames.TransactionCompteId: id,
      Bdcolumnnames.TransactionCompteSource: compteSourceId,
      Bdcolumnnames.TransactionCompteDestination: compteDestinationId,
      Bdcolumnnames.TransactionCompteMontantTransactions: montantTransaction,
      Bdcolumnnames.TransactionCompteSoldeSourceAvant: soldeSourceAvant,
      Bdcolumnnames.TransactionCompteSoldeDestinationAvant:
          soldeDestinationAvant,
      Bdcolumnnames.TransactionCompteSoldeSource: soldeSource,
      Bdcolumnnames.TransactionCompteSoldeDestination: soldeDestination,
      Bdcolumnnames.TransactionCompteTaux: taux,
      Bdcolumnnames.TransactionCompteDate: date?.toIso8601String(),
      Bdcolumnnames.TransactionCompteidAgent: idAgent,
      Bdcolumnnames.TransactionCompteLibele: libele,
      Bdcolumnnames.TransactionCompteService: service,
      Bdcolumnnames.TransactionCompteproprietaire: proprietaire,
    };
  }
}
