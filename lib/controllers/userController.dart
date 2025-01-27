import 'package:bcccoin/bd/hive_boxes.dart';
import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/models/TransactionCompteModel.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'dart:math';

class UserController extends GetxController {
  late Box<UserModel> userBoxe;
  UserModel? userModelTosend;

  @override
  void onInit() {
    super.onInit();

    userBoxe = Hive.box<UserModel>(userBox);
    loadUserData();
  }

  Future<bool> logoutUser() async {
    try {
      // Réinitialiser l'utilisateur actuel
      userModelTosend = null;
      await Hive.box<UserModel>(userBox).clear();
      await Hive.box<CompteModel>(compteBox).clear();
      await Hive.box<TransactionCompteModel>(transactionCompteBox).clear();
      // TransactionCompteModel

      // Fermer toutes les boxes Hive
      await Hive.box<UserModel>(userBox).close();
      await Hive.box<CompteModel>(compteBox).close();
      await Hive.box<TransactionCompteModel>(transactionCompteBox).close();

      // Réinitialiser le stockage local si nécessaire
      await GetStorage().erase();
      await GetStorage("Bcc").erase();

      return true;
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
      return false;
    }
  }

  Future<bool> loginUser(String phoneNumber, String password) async {
    try {
      final users = userBoxe.values.toList();
      final user = users.firstWhere(
        (u) =>
            u.phonenumber?.trim() == phoneNumber.trim() &&
            u.password?.trim() == password.trim(),
        orElse: () => throw Exception('Utilisateur non trouvé'),
      );

      userModelTosend = user;
      return true;
    } catch (e) {
      print('Erreur de connexion: $e');
      return false;
    }
  }

  Future<bool> registerUser(UserModel user) async {
    try {
      Hive.openBox(userBox);
      // Vérifier si l'utilisateur existe déjà
      final exists =
          userBoxe.values.any((u) => u.phonenumber == user.phonenumber);
      if (exists) {
        print("Exists");
        return false;
      }

      // Générer un ID unique
      user.id = userBoxe.length + 1;
      user.bankName = choisirBanqueCommercial();

      // Sauvegarder l'utilisateur
      await userBoxe.add(user);

      print('added');
      await _addUserAccounts(user);
      return true;
    } catch (e) {
      print('Erreur d\'enregistrement: $e');
      return false;
    }
  }

  Future<void> _addUserAccounts(UserModel user) async {
    Get.put(CompteController());
    final compteController = Get.find<
        CompteController>(); // On suppose que GetX est utilisé pour gérer les controllers

    // Créer les comptes avec solde 0 et les devises spécifiées
    List<CompteModel> comptes = [
      CompteModel(
        devise: 'USD',
        name: 'USD Account',
        solde: 0.0,
        userModel: user, // Associer l'utilisateur à chaque compte
      ),
      CompteModel(
        devise: 'CDF',
        name: 'CDF Account',
        solde: 0.0,
        userModel: user,
      ),
      CompteModel(
        devise: 'CBC',
        name: 'CBC Account',
        solde: 0.0,
        userModel: user,
      ),
      CompteModel(
        devise: 'BTC',
        name: 'BTC Account',
        solde: 0.0,
        userModel: user,
      ),
      CompteModel(
        devise: 'ETH',
        name: 'ETH Account',
        solde: 0.0,
        userModel: user,
      ),
    ];

    await compteController.addCompte(comptes[0]);

    await compteController.addCompte(comptes[1]);
    await compteController.addCompte(comptes[2]);
    await compteController.addCompte(comptes[3]);
  }

  void loadUserData() {
    if (userModelTosend != null) {
      print("User data loaded: ${userModelTosend?.toJson()}");
    } else {
      print("Aucun utilisateur connecté");
    }
  }

  UserModel? getUserModel() {
    return userModelTosend;
  }

  bool isUserLoggedIn() {
    return userModelTosend != null;
  }

  // Méthode pour charger l'utilisateur au démarrage
  Future<bool> loadInitialUser() async {
    try {
      final users = userBoxe.values.toList();
      if (users.isNotEmpty) {
        // Prendre le dernier utilisateur connecté
        userModelTosend = users.last;
        return true;
      }
      return false;
    } catch (e) {
      print('Erreur de chargement initial: $e');
      return false;
    }
  }

  String choisirBanqueCommercial() {
    // Liste des banques disponibles en RDC
    List<String> banques = [
      "Rawbank",
      "Trust Merchant Bank (TMB)",
      "Equity Bank",
      "Banque Commerciale du Congo (BCDC)",
      "Afriland First Bank",
      "United Bank for Africa (UBA)",
      "Ecobank",
      "FBNBank",
      "Advans Banque",
      "Access Bank",
      "Standard Bank"
    ];

    if (banques.isEmpty) {
      throw Exception(
          "La liste des banques est vide. Veuillez ajouter des banques.");
    }

    int indexAleatoire = Random().nextInt(banques.length);

    return banques[indexAleatoire];
  }
}
