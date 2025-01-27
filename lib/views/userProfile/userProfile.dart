import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/controllers/userController.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserController userController = Get.put(UserController());

  CompteController compteController = Get.put(CompteController());

  List<CompteModel> comptes = [];

  void loadComptes() {
    setState(() {
      comptes =
          compteController.compteBoxe.values.toList(); // Récupère les comptes
      print("Comptes chargés : ${comptes[1].name} ${comptes[1].solde}");
    });
  }

  @override
  void initState() {
    super.initState();
    loadComptes();
  }

  // Données utilisateur simulées
  final Map<String, String> userPersonalInfo = {
    'Nom': 'John Doe',
    'Téléphone': '+243 812 345 678',
    'Email': 'john.doe@example.com',
    'Date de naissance': '1990-05-14',
    'Genre': 'Masculin',
    'Pays': 'RD Congo',
  };

  final Map<String, String> userAdditionalInfo = {
    'Numéro': '123',
    'Avenue': 'Avenue de la Paix',
    'Quartier': 'Gombe',
    'Commune': 'Kinshasa',
  };

  // Liste des comptes simulés
  final List<Map<String, dynamic>> userAccounts = [
    {
      'Devise': 'USD',
      'Nom': 'Compte Courant',
      'Solde': 1200.50,
    },
    {
      'Devise': 'CDF',
      'Nom': 'Compte Épargne',
      'Solde': 550000.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    UserModel? user = userController.getUserModel();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Profil Utilisateur'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section : Informations Personnelles
            _buildSection(
              title: 'Informations Personnelles',
              content: _buildInfoListA(user!),
            ),

            // Section : Informations Additionnelles
            _buildSection(
              title: 'Informations Additionnelles',
              content: _buildInfoList(user),
            ),

            // Section : Comptes sur CBC
            _buildSection(
              title: 'Comptes sur CBC',
              content: Column(
                children: comptes
                    .map((account) => _buildAccountCard(account))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour une section avec titre et contenu
  Widget _buildSection({required String title, required Widget content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  // Widget pour afficher une liste d'informations (clé-valeur)
  Widget _buildInfoListA(UserModel info) {
    // Liste des informations à afficher sous forme de paires clé-valeur
    final userInfo = [
      {'Name': info.name},
      {'Email': info.email},
      {'Phone Number': info.phonenumber},
      {'Date of Birth': info.dateOfBirth},
      {'Gender': info.gender},
    ];

    return Column(
      children: userInfo.map((entry) {
        String key = entry.keys.first; // La clé de chaque paire
        String? value = entry[key]; // La valeur correspondante
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$key: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Text(
                  value ?? 'N/A', // Si la valeur est nulle, afficher 'N/A'
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoList(UserModel info) {
    // Liste des informations à afficher sous forme de paires clé-valeur
    final userInfo = [
      {'Number': info.number},
      {'Avenue': info.avenue},
      {'Quartier': info.quartier},
      {'Commune': info.commune},
    ];

    return Column(
      children: userInfo.map((entry) {
        String key = entry.keys.first; // La clé de chaque paire
        String? value = entry[key]; // La valeur correspondante
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$key: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Text(
                  value ?? 'N/A', // Si la valeur est nulle, afficher 'N/A'
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget pour afficher un compte sous forme de carte
  Widget _buildAccountCard(CompteModel account) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            account.name ?? 'No Name', // Affichage du nom du compte
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Devise: ${account.devise ?? 'N/A'}', // Affichage de la devise
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Solde: ${account.solde?.toStringAsFixed(2) ?? '0.00'} ${account.devise ?? ''}', // Affichage du solde
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Id Compte: ', // Affichage du titre "Numéro"
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              // Utilisation de Flexible pour éviter le dépassement
              Flexible(
                child: Text(
                  '${account.id ?? 'N/A'}',
                  style: const TextStyle(color: Colors.white70),
                  overflow: TextOverflow
                      .ellipsis, // Ajoute des points de suspension si le texte dépasse
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
