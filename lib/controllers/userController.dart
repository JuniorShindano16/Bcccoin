import 'package:bcccoin/bd/hive_boxes.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:get/get.dart';


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
    
      // Fermer toutes les boxes Hive
      await Hive.box<UserModel>(userBox).close();
   

      // Réinitialiser le stockage local si nécessaire
      await GetStorage().erase();
      await GetStorage("Hcm").erase();

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
      // Vérifier si l'utilisateur existe déjà
      final exists =
          userBoxe.values.any((u) => u.phonenumber == user.phonenumber);
      if (exists) {
        print("Exists");
        return false;
      }

      // Générer un ID unique
      user.id = userBoxe.length + 1;

      // Sauvegarder l'utilisateur
      await userBoxe.add(user);

      print('added');
      return true;
    } catch (e) {
      print('Erreur d\'enregistrement: $e');
      return false;
    }
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
}
