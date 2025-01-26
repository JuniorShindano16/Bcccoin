import 'package:bcccoin/controllers/homeController.dart';
import 'package:bcccoin/controllers/userController.dart';
import 'package:bcccoin/models/TransactionCompteModel.dart';
import 'package:bcccoin/models/TransactionCompteModel.g.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:bcccoin/models/compteModel.g.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:bcccoin/models/userModel.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bcccoin/bd/hive_boxes.dart';

// import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class Setting {
  static Future<void> initUser() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();

      // Enregistrer les adaptateurs
      Hive.registerAdapter(UserModelAdapter()); // typeId: 1
      Hive.registerAdapter(CompteModelAdapter()); // typeId: 2
      Hive.registerAdapter(TransactionCompteModelAdapter()); // typeId: 3

      // Ouvrir les boxes
      await Hive.openBox<UserModel>(userBox);
      await Hive.openBox<CompteModel>(compteBox);
      await Hive.openBox<TransactionCompteModel>(transactionCompteBox);
      // await Hive.openBox<TransactionCompteModel>(transactionCompteBox);

      await GetStorage.init();

      // await GetStorage.init("Hcm");
      // await Hive.initFlutter();

      // Enregistrer les adaptateurs
      // Hive.registerAdapter(MoodModelAdapter());
      // Hive.registerAdapter(PainModelAdapter());
      // Hive.registerAdapter(VitalSignModelAdapter());

      // Ouvrir les boxes
      // await Hive.openBox(userBox);
      // await Hive.openBox<MoodModel>(moodBox);
      // await Hive.openBox<PainModel>(painBox);
      // await Hive.openBox<VitalSignModel>(vitalSignBox);
      // await Hive.openBox<PrescriptionModel>(prescriptionBox);
      // await Hive.openBox<MedicationModel>(medicationBox);
      // await Hive.openBox<MedicationIntakeModel>(medicationIntakeBox);

      storage = GetStorage("Bcc");
    } catch (e) {
      // await GetStorage.init();
      print("c'est ici qu'est l'erreur " + "$e");
    }

    // storageIdentity = GetStorage("SawaidIdentity");
  }

  static late GetStorage storage;
  // static late GetStorage storageIdentity;
  static HomeController get Home_controller {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  static UserController get User_controller {
    try {
      return Get.find<UserController>();
    } catch (e) {
      return Get.put(UserController());
    }
  }
}
