import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepotAgentPage extends StatefulWidget {
  @override
  _DepotAgentPageState createState() => _DepotAgentPageState();
}

class _DepotAgentPageState extends State<DepotAgentPage> {
  String selectedCurrency = 'CDF'; // Devise sélectionnée par défaut
  double currentBalance = 35466.0; // Solde par défaut pour CDF
  List<double> quickAmountsCDF = [
    10000,
    20000,
    50000,
    100000
  ]; // Montants rapides pour CDF

  List<double> quickAmountsUSD = [10, 20, 50, 100];

  List<double> quickAmounts = [10000, 20000, 50000, 100000];

  TextEditingController montantController = TextEditingController();
  TextEditingController numeroAgentController = TextEditingController();
  TextEditingController descriptionController =
      TextEditingController(text: 'Dépot locale');
  bool isButtonActive = false; // Bouton "Continuer" actif ou inactif

  // Liste des comptes disponibles
  List<CompteModel> comptes = [];
  CompteModel? selectedCompte; // Compte sélectionné par l'utilisateur

  List<CompteModel> comptesTop = [];

  CompteController compteController = Get.put(CompteController());
  // Get.find<CompteController>(); // Récupération du CompteController

  @override
  void initState() {
    super.initState();
    montantController.addListener(validateForm);
    numeroAgentController.addListener(validateForm);
    loadComptes();
  }

  @override
  void dispose() {
    montantController.dispose();
    numeroAgentController.dispose();
    super.dispose();
  }

  void loadComptes() {
    setState(() {
      comptes =
          compteController.compteBoxe.values.toList(); // Récupère les comptes
      print("Comptes chargés : ${comptes[1].name} ${comptes[1].solde}");
      comptesTop = comptes
          .where((compte) => compte.devise == 'CDF' || compte.devise == 'USD')
          .toList();

      // Affiche les détails pour vérifier
      print(
          "Comptes chargés : ${comptes.map((c) => '${c.name} (${c.devise}) ${c.solde}').toList()}");
      print(
          "Comptes filtrés (CDF et USD) : ${comptesTop.map((c) => '${c.name} (${c.devise})').toList()}");
    });
  }

  void updateAmount(double amount) {
    setState(() {
      montantController.text = amount.toStringAsFixed(2);
      validateForm(); // Vérifie si les champs sont remplis
    });
  }

  void validateForm() {
    setState(() {
      isButtonActive = montantController.text.isNotEmpty &&
          numeroAgentController.text.isNotEmpty;
    });
  }

  void deposit(CompteModel selectedCompte) async {
    if (selectedCompte != null) {
      double montant = double.parse(montantController.text);

      print(
          'Tentative de dépôt de $montant sur le compte ID: ${selectedCompte.id}');
      print(
          'Compte sélectionné : ${selectedCompte.name}, Solde : ${selectedCompte.solde}, Devise : ${selectedCompte?.devise}');

      bool success = await compteController.ravitaillerCompte(
          selectedCompte.id ?? '', // Assurez-vous que l'ID est valide
          montant,
          numeroAgentController.text,
          descriptionController.text);

      if (success) {
        setState(() {
          // Rechargez les données depuis la base pour éviter des incohérences
          loadComptes();
          currentBalance = selectedCompte.solde ?? 0.0;
        });

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Dépôt effectué avec succès'),
        //   backgroundColor: Colors.green,
        // ));

        _showDialog("Succès", "Dépôt effectué avec succès !");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors du dépôt'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Aucun compte sélectionné'),
        backgroundColor: Colors.red,
      ));
      // _showDialog("Erreur", "Aucun compte sélectionné.");
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context, //cez par le contexte approprié
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.green),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateCurrency(String currency) {
    setState(() {
      selectedCurrency = currency;
      if (currency == 'CDF') {
        currentBalance = 35466.0;
        quickAmounts = [10000, 20000, 50000, 100000];
      } else if (currency == 'USD') {
        currentBalance = 100.0;
        quickAmounts = [10, 20, 50, 100];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Depot Argent",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card principale
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre avec Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Depot sur: ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<CompteModel>(
                          value: selectedCompte,
                          dropdownColor: Colors.grey[900],
                          style: TextStyle(color: Colors.white),
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                          items: comptes.map((compte) {
                            return DropdownMenuItem<CompteModel>(
                              value: compte,
                              child: Text(
                                compte.name ?? 'Compte inconnu',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCompte =
                                  value; // Mettez à jour d'abord la sélection
                              currentBalance = selectedCompte?.solde ??
                                  0.0; // Met à jour le solde
                              if (selectedCompte?.devise == 'USD') {
                                quickAmounts = quickAmountsUSD;
                              } else if (selectedCompte?.devise == 'CDF') {
                                quickAmounts = quickAmountsCDF;
                              }
                            });

                            validateForm(); // Valider le formulaire après sélection du compte
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Numéro Agent
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: numeroAgentController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Numéro mobile money",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon:
                            Icon(Icons.phone_android, color: Colors.white),
                      ),
                    ),
                    // SizedBox(height: 16),
                    // // Numéro Agent
                    // TextField(
                    //   keyboardType: TextInputType.phone,
                    //   controller: descriptionController,
                    //   style: TextStyle(color: Colors.white),
                    //   decoration: InputDecoration(
                    //     labelText: "Description",
                    //     labelStyle: TextStyle(color: Colors.grey),
                    //     filled: true,
                    //     fillColor: Colors.grey[850],
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 16),
                    // Montant
                    TextField(
                      controller: montantController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Montant",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffix: Text(
                          "Solde actuel: ${selectedCompte != null ? (selectedCompte!.solde!).toStringAsFixed(1) : 0}",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Boutons de montant rapide
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: quickAmounts.map((amount) {
                        return _buildQuickAmountButton(amount);
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              // Bouton Continuer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          print(comptes);
                          deposit(selectedCompte!);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonActive
                        ? Colors.green
                        : Colors.grey, // Couleur verte si actif
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Continuer",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(double amount) {
    return ElevatedButton(
      onPressed: () => updateAmount(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        "${amount.toStringAsFixed(1)} ${selectedCompte?.devise}",
        style: TextStyle(color: Colors.white, fontSize: 8),
      ),
    );
  }
}
