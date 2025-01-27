import 'package:bcccoin/bd/hive_boxes.dart';
import 'package:bcccoin/models/TransactionCompteModel.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CompteController extends GetxController {
  late Box<CompteModel> compteBoxe;
  late Box<TransactionCompteModel> transactionCompteBoxe;
  CompteModel? currentCompte;

  @override
  void onInit() {
    super.onInit();
    compteBoxe = Hive.box<CompteModel>(compteBox);
    transactionCompteBoxe =
        Hive.box<TransactionCompteModel>(transactionCompteBox);

    loadCurrentCompte();
  }

  Future<bool> effectuerEchangeAchatCbc({
    required CompteModel compteSource,
    required CompteModel compteDestination,
    required double montant,
    required double tauxEchange,
  }) async {
    try {
      // Validation des soldes et des paramètres
      double soldeSourceAvant = compteSource.solde ?? 0.0;
      double soldeDestinationAvant = compteDestination.solde ?? 0.0;

      if (soldeSourceAvant < montant) {
        print(
            "Solde insuffisant dans le compte source pour effectuer l'échange.");
        return false;
      }

      // Calcul des nouveaux soldes
      double montantConverti = montant / tauxEchange;
      double nouveauSoldeSource = soldeSourceAvant - montant;
      double nouveauSoldeDestination = soldeDestinationAvant + montantConverti;

      // Mise à jour des comptes
      compteSource.solde = nouveauSoldeSource;
      compteDestination.solde = nouveauSoldeDestination;

      await compteSource.save();

      print(
          "Source solde et devise : ${compteSource.solde} && ${compteSource.devise}");
      await compteDestination.save();
      print(
          "Destination solde et devise : ${compteDestination.solde} && ${compteDestination.devise}");

      // Enregistrement de la transaction dans la table des transactions
      final transaction = TransactionCompteModel(
          id: transactionCompteBoxe.length + 1,
          compteSourceId: compteSource.id,
          compteDestinationId: compteDestination.id,
          montantTransaction: montant,
          soldeSourceAvant: soldeSourceAvant,
          soldeSource: nouveauSoldeSource,
          soldeDestinationAvant: soldeDestinationAvant,
          soldeDestination: nouveauSoldeDestination,
          taux: tauxEchange,
          date: DateTime.now(),
          idAgent: 'Systeme');

      await transactionCompteBoxe.add(transaction);

      print(
          "Échange effectué avec succès : $montant ${compteSource.devise} convertis en $montantConverti ${compteDestination.devise} au taux de ${tauxEchange}.");
      return true;
    } catch (e) {
      print("Erreur lors de l'échange : $e");
      return false;
    }
  }

  Future<bool> effectuerEchangeAutre({
    required CompteModel compteSource,
    required CompteModel compteDestination,
    required double montant,
    required double tauxEchange,
  }) async {
    try {
      // Validation des soldes et des paramètres
      double soldeSourceAvant = compteSource.solde ?? 0.0;
      double soldeDestinationAvant = compteDestination.solde ?? 0.0;

      if (soldeSourceAvant < montant) {
        print(
            "Solde insuffisant dans le compte source pour effectuer l'échange.");
        return false;
      }

      // Calcul des nouveaux soldes
      double montantConverti = montant * tauxEchange;
      double nouveauSoldeSource = soldeSourceAvant - montant;
      double nouveauSoldeDestination = soldeDestinationAvant + montantConverti;

      // Mise à jour des comptes
      compteSource.solde = nouveauSoldeSource;
      compteDestination.solde = nouveauSoldeDestination;

      await compteSource.save();

      print(
          "Source solde et devise : ${compteSource.solde} && ${compteSource.devise}");
      await compteDestination.save();
      print(
          "Destination solde et devise : ${compteDestination.solde} && ${compteDestination.devise}");

      // Enregistrement de la transaction dans la table des transactions
      final transaction = TransactionCompteModel(
          id: transactionCompteBoxe.length + 1,
          compteSourceId: compteSource.id,
          compteDestinationId: compteDestination.id,
          montantTransaction: montant,
          soldeSourceAvant: soldeSourceAvant,
          soldeSource: nouveauSoldeSource,
          soldeDestinationAvant: soldeDestinationAvant,
          soldeDestination: nouveauSoldeDestination,
          taux: tauxEchange,
          date: DateTime.now(),
          idAgent: 'Systeme');

      await transactionCompteBoxe.add(transaction);

      print(
          "Échange effectué avec succès : $montant ${compteSource.devise} convertis en $montantConverti ${compteDestination.devise} au taux de ${tauxEchange}.");
      return true;
    } catch (e) {
      print("Erreur lors de l'échange : $e");
      return false;
    }
  }

  Future<bool> retirerArgentPourVirement(String compteId, double montant,
      String Numero, String libele, String proprietaire) async {
    try {
      final compte = compteBoxe.values.firstWhere(
        (c) => c.id == compteId,
      );

      double soldeAvant = compte.solde ?? 0.0;

      if (soldeAvant < montant) {
        print("Solde insuffisant pour effectuer cette opération");
        return false;
      }

      double nouveauSolde = soldeAvant - montant;

      compte.solde = nouveauSolde;
      await compte.save();

      final transaction = TransactionCompteModel(
        id: transactionCompteBoxe.length + 1,
        compteSourceId: compteId,
        compteDestinationId: null,
        montantTransaction: -montant,
        soldeSourceAvant: soldeAvant,
        soldeSource: nouveauSolde,
        soldeDestinationAvant: null,
        soldeDestination: null,
        taux: null,
        date: DateTime.now(),
        idAgent: Numero,
        libele: libele,
        proprietaire: proprietaire,
      );

      print('propriooooooooo : ${transaction.proprietaire}');

      await transactionCompteBoxe.add(transaction);

      print("Montant retiré avec succès : -$montant");
      return true;
    } catch (e) {
      print("Erreur lors du retrait : $e");
      return false;
    }
  }

  Future<bool> retirerArgentPourAchat(
      String compteId, double montant, String Numero, String libele) async {
    try {
      final compte = compteBoxe.values.firstWhere(
        (c) => c.id == compteId,
      );

      double soldeAvant = compte.solde ?? 0.0;

      if (soldeAvant < montant) {
        print("Solde insuffisant pour effectuer cette opération");
        return false;
      }

      double nouveauSolde = soldeAvant - montant;

      compte.solde = nouveauSolde;
      await compte.save();

      final transaction = TransactionCompteModel(
        id: transactionCompteBoxe.length + 1,
        compteSourceId: compteId,
        compteDestinationId: null,
        montantTransaction: -montant,
        soldeSourceAvant: soldeAvant,
        soldeSource: nouveauSolde,
        soldeDestinationAvant: null,
        soldeDestination: null,
        taux: null,
        date: DateTime.now(),
        idAgent: Numero,
        libele: libele,
      );

      await transactionCompteBoxe.add(transaction);

      print("Montant retiré avec succès : -$montant");
      return true;
    } catch (e) {
      print("Erreur lors du retrait : $e");
      return false;
    }
  }

  Future<bool> retirerArgentPourAchatTv(String compteId, double montant,
      String Numero, String libele, service) async {
    try {
      final compte = compteBoxe.values.firstWhere(
        (c) => c.id == compteId,
      );

      double soldeAvant = compte.solde ?? 0.0;

      if (soldeAvant < montant) {
        print("Solde insuffisant pour effectuer cette opération");
        return false;
      }

      double nouveauSolde = soldeAvant - montant;

      compte.solde = nouveauSolde;
      await compte.save();

      final transaction = TransactionCompteModel(
        id: transactionCompteBoxe.length + 1,
        compteSourceId: compteId,
        compteDestinationId: null,
        montantTransaction: -montant,
        soldeSourceAvant: soldeAvant,
        soldeSource: nouveauSolde,
        soldeDestinationAvant: null,
        soldeDestination: null,
        taux: null,
        date: DateTime.now(),
        idAgent: Numero,
        libele: libele,
      );

      await transactionCompteBoxe.add(transaction);

      print("Montant retiré avec succès : -$montant");
      return true;
    } catch (e) {
      print("Erreur lors du retrait : $e");
      return false;
    }
  }

  Future<bool> retirerArgent(
      String compteId, double montant, String Numero, String libele) async {
    try {
      final compte = compteBoxe.values.firstWhere(
        (c) => c.id == compteId,
      );

      double soldeAvant = compte.solde ?? 0.0;

      if (soldeAvant < montant) {
        print("Solde insuffisant pour effectuer cette opération");
        return false;
      }

      double nouveauSolde = soldeAvant - montant;

      compte.solde = nouveauSolde;
      await compte.save();

      CompteModel? compteTransaction;

      compteTransaction!.devise = compte.devise;
      compteTransaction.name = Numero + compte.devise!;
      compteTransaction.id = "56";

      final transaction = TransactionCompteModel(
          id: transactionCompteBoxe.length + 1,
          compteSourceId: compteId,
          compteDestinationId: compteTransaction.name,
          montantTransaction: -montant,
          soldeSourceAvant: soldeAvant,
          soldeSource: nouveauSolde,
          soldeDestinationAvant: null,
          soldeDestination: null,
          taux: null,
          date: DateTime.now(),
          idAgent: Numero,
          libele: '$libele chez agent $Numero');

      await transactionCompteBoxe.add(transaction);

      print("Montant retiré avec succès : -$montant");
      return true;
    } catch (e) {
      print("Erreur lors du retrait : $e");
      return false;
    }
  }

  Future<bool> ravitaillerCompte(String compteId, double montant, String numero,
      String description) async {
    try {
      final compte = compteBoxe.values.firstWhere(
        (c) => c.id == compteId,
      );

      double soldeAvant = compte.solde ?? 0.0;
      double nouveauSolde = soldeAvant + montant;

      // Mise à jour du solde du compte
      compte.solde = nouveauSolde;
      await compte.save();
      CompteModel? compteTransaction;

      compteTransaction!.devise = compte.devise;
      compteTransaction.name = numero + compte.devise!;
      compteTransaction.id = "56";

      // Création de la transaction
      final transaction = TransactionCompteModel(
          id: transactionCompteBoxe.length + 1,
          compteSourceId: compteId,
          compteDestinationId: compteTransaction.name,
          montantTransaction: montant,
          soldeSourceAvant: soldeAvant,
          soldeSource: nouveauSolde,
          soldeDestinationAvant: null,
          soldeDestination: null,
          taux: null,
          date: DateTime.now(),
          idAgent: numero,
          libele: description);

      // Ajout de la transaction
      await transactionCompteBoxe.add(transaction);

      print("Compte ravitaillé avec succès : +$montant");
      return true;
    } catch (e) {
      print("Erreur lors du ravitaillement : $e");
      return false;
    }
  }

  Future<bool> addCompte(CompteModel compte) async {
    try {
      final exists = compteBoxe.values.any((c) => c.name == compte.name);
      if (exists) {
        print("Compte déjà existant avec ce nom");
        return false;
      }

      // Utilisation d'un UUID pour générer un identifiant unique
      var uuid = Uuid();
      compte.id = uuid.v4(); // Génère un ID unique basé sur UUID

      // Ajouter le compte à la base
      await compteBoxe.add(compte);
      print("Compte ajouté avec succès");
      return true;
    } catch (e) {
      print("Erreur lors de l'ajout du compte: $e");
      return false;
    }
  }

  Future<bool> updateCompte(int id, Map<String, dynamic> updates) async {
    try {
      final compte = compteBoxe.values.firstWhere((c) => c.id == id);
      if (compte != null) {
        updates.forEach((key, value) {
          switch (key) {
            case 'name':
              compte.name = value;
              break;
            case 'devise':
              compte.devise = value;
              break;
            case 'solde':
              compte.solde = value;
              break;
            default:
              print("Clé non reconnue: $key");
          }
        });
        await compte.save();
        print("Compte mis à jour avec succès");
        return true;
      }
      return false;
    } catch (e) {
      print("Erreur lors de la mise à jour du compte: $e");
      return false;
    }
  }

  Future<bool> deleteCompte(int id) async {
    try {
      final compteIndex =
          compteBoxe.values.toList().indexWhere((c) => c.id == id);
      if (compteIndex != -1) {
        await compteBoxe.deleteAt(compteIndex);
        print("Compte supprimé avec succès");
        return true;
      }
      return false;
    } catch (e) {
      print("Erreur lors de la suppression du compte: $e");
      return false;
    }
  }

  CompteModel? getCompteById(int id) {
    try {
      final compte = compteBoxe.values.firstWhere((c) => c.id == id,
          orElse: () => throw Exception("Compte introuvable"));
      return compte;
    } catch (e) {
      print("Erreur lors de la récupération du compte: $e");
      return null;
    }
  }

  List<CompteModel> getAllComptes() {
    return compteBoxe.values.toList();
  }

  Future<bool> loadCurrentCompte() async {
    try {
      if (compteBox.isNotEmpty) {
        currentCompte = compteBoxe.values.last;
        print("Compte chargé: ${currentCompte?.toJson()}");
        return true;
      }
      return false;
    } catch (e) {
      print("Erreur lors du chargement du compte courant: $e");
      return false;
    }
  }

  Future<bool> clearAllComptes() async {
    try {
      await compteBoxe.clear();
      currentCompte = null;
      print("Tous les comptes ont été effacés");
      return true;
    } catch (e) {
      print("Erreur lors de l'effacement des comptes: $e");
      return false;
    }
  }

  bool isCompteAvailable() {
    return currentCompte != null;
  }

  void printCompteData() {
    if (currentCompte != null) {
      print("Données du compte courant: ${currentCompte?.toJson()}");
    } else {
      print("Aucun compte chargé");
    }
  }
}
