import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class envoiversAutreCompte extends StatefulWidget {
  @override
  _envoiversAutreCompteState createState() => _envoiversAutreCompteState();
}

class _envoiversAutreCompteState extends State<envoiversAutreCompte> {
  String selectedCurrency = 'CDF'; // Devise sélectionnée par défaut
  double currentBalance = 35466.0; // Solde par défaut pour CDF
  List<double> quickAmountsCDF = [
    10000,
    20000,
    50000,
    100000
  ]; // Montants rapides pour CDF
  final Map<String, String> cpt = {
    '12345': 'John Doe',
    '67890': 'Jane Smith',
    '11223': 'Alice Johnson',
    '44556': 'Bob Brown',
  };

  List<double> quickAmountsUSD = [10, 20, 50, 100];

  List<double> quickAmounts = [10000, 20000, 50000, 100000];

  CompteController compteController = Get.put(CompteController());

  TextEditingController montantController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numeroCompteController = TextEditingController();
  String proprietaire = '';
  bool isButtonActive = false; // Bouton "Continuer" actif ou inactif
  List<CompteModel> comptes = [];
  List<CompteModel> comptesTop = [];
  CompteModel? selectedCompte;

  // Fonction pour mettre à jour les données selon la devise choisie
  void updateCurrency(CompteModel? selectedCompte) {
    setState(() {
      String currentCurrency = selectedCompte!.devise!;

      if (currentCurrency == 'CDF') {
        currentBalance = 35466.0;
        quickAmounts = quickAmountsCDF;
      } else if (currentCurrency == 'USD') {
        currentBalance = 100.0;
        quickAmounts = quickAmountsUSD;
      }
    });
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

  void withdraw(CompteModel selectedCompte) async {
    if (selectedCompte != null) {
      double montant = double.parse(montantController.text);

      print(
          'Tentative de retrait de $montant du compte ID: ${selectedCompte.id}');
      print(
          'Compte sélectionné : ${selectedCompte.name}, Solde : ${selectedCompte.solde}, Devise : ${selectedCompte.devise}');

      // Vérifiez si le solde est suffisant
      if (selectedCompte.solde != null && montant <= selectedCompte.solde!) {
        bool success = await compteController.retirerArgentPourVirement(
            selectedCompte.id ?? '',
            montant,
            numeroCompteController.text,
            descriptionController.text, proprietaire);

        if (success) {
          setState(() {
            // Rechargez les données depuis la base pour éviter des incohérences
            loadComptes();
            currentBalance = selectedCompte.solde ?? 0.0;
          });

          _showDialog("Succès", "Virement effectuer avec succès!");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Erreur lors de Achat'),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Solde insuffisant pour effectuer virement'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Aucun compte sélectionné'),
        backgroundColor: Colors.red,
      ));
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

  void updateAmount(double amount) {
    setState(() {
      montantController.text = amount.toStringAsFixed(2);
      validateForm();
    });
  }

  void validateForm() {
    setState(() {
      isButtonActive = montantController.text.isNotEmpty &&
          numeroCompteController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    montantController.addListener(validateForm);
    numeroCompteController.addListener(validateForm);
    loadComptes();
  }

  @override
  void dispose() {
    montantController.dispose();
    numeroCompteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Effectuer Virement",
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
                          "Acheter avec de: ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<CompteModel>(
                          value: selectedCompte,
                          dropdownColor: Colors.grey[900],
                          style: TextStyle(color: Colors.white),
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                          items: comptesTop.map((compte) {
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
                            validateForm();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Numéro Agent
                    TextField(
                      onSubmitted: (value) {
                        // Recherche du propriétaire dans la liste
                        setState(() {
                          proprietaire =
                              cpt[value] ?? 'Propriétaire non trouvé';
                        });
                        print('proprietaire ');
                      },
                      keyboardType: TextInputType.phone,
                      controller: numeroCompteController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Numéro de Compte",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: proprietaire.isNotEmpty
                            ? Text(
                                proprietaire,
                                style: TextStyle(color: Colors.white),
                              )
                            : Icon(Icons.account_circle, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Montant
                    TextField(
                      controller: descriptionController,
                      style: TextStyle(color: Colors.white),
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        // suffix: Text(
                        //   "Solde actuel: ${selectedCompte != null ? (selectedCompte!.solde!).toStringAsFixed(2) : 0}",
                        //   style: TextStyle(color: Colors.green, fontSize: 14),
                        // ),
                      ),
                    ),
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
                          "Solde actuel: ${selectedCompte != null ? (selectedCompte!.solde!).toStringAsFixed(2) : 0}",
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
                          withdraw(selectedCompte!);
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
        "${amount.toStringAsFixed(1)} ${selectedCompte != null ? selectedCompte?.devise : "CDF"}",
        style: TextStyle(color: Colors.white, fontSize: 8),
      ),
    );
  }
}
