import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcheterCBCScreen extends StatefulWidget {
  @override
  _AcheterCBCScreenState createState() => _AcheterCBCScreenState();
}

class _AcheterCBCScreenState extends State<AcheterCBCScreen> {
  String selectedCurrency = 'CDF'; // Devise sélectionnée par défaut
  double currentBalance = 35466.0; // Solde par défaut pour CDF
  double cbcAmount = 0; // Montant de CBC à acheter
  String selectedWallet = "BTC"; // Portefeuille sélectionné par défaut
  double walletBalance = 0; // Solde du portefeuille sélectionné
  CompteController compteController = Get.put(CompteController());
  List<CompteModel> comptes = [];
  List<CompteModel> comptesTop = [];
  CompteModel? selectedCompte;

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _amountController.text = "0.00"; // Valeur initiale
    loadComptes();
  }

  void loadComptes() {
    setState(() {
      comptes =
          compteController.compteBoxe.values.toList(); // Récupère les comptes
      print("Comptes chargés : ${comptes[1].name} ${comptes[1].solde}");
      comptesTop = comptes
          .where((compte) =>
              compte.devise == 'CDF' ||
              compte.devise == 'USD' ||
              compte.devise == 'BTC')
          .toList();
    });
  }

  void _updateCBCAmount(String value, CompteModel selected) {
    double tauxEchange;
    switch (selectedCompte!.devise) {
      case 'CDF':
        tauxEchange = 5950;
        break;
      case 'USD':
        tauxEchange = 2.9815;
        break;
      case 'BTC':
        tauxEchange = 0.95;
        break;
      case 'ETH':
        tauxEchange = 1.85;
        break;
      default:
        print("Devise non prise en charge pour l'échange.");
        return;
    }
    if (value.isEmpty) {
      setState(() {
        cbcAmount = 0;
      });
      return;
    }

    final parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue != null) {
      setState(() {
        cbcAmount = parsedValue / tauxEchange;
      });
    }
  }

  void _acheterCBC(CompteModel selectedCompte) async {
    if (selectedCompte == null) {
      _showDialog("Erreur", "Veuillez sélectionner un compte.");
      print("Veuillez sélectionner un compte.");
      return;
    }

    if (cbcAmount <= 0) {
      _showDialog("Erreur", "Montant invalide pour l'achat.");
      print("Montant invalide pour l'achat.");
      return;
    }

    double montant = double.parse(_amountController.text);
    double tauxEchange = 1;
    switch (selectedCompte.devise) {
      case 'CDF':
        tauxEchange = 5950;
        break;
      case 'USD':
        tauxEchange = 2.9815;
        break;
      case 'BTC':
        tauxEchange = 0.95;
        break;
      case 'ETH':
        tauxEchange = 1.85;
        break;
      default:
        _showDialog("Erreur", "Devise non prise en charge pour l'échange.");
        print("Devise non prise en charge pour l'échange.");
        return;
    }

    if (selectedCompte.solde! < montant) {
      _showDialog("Erreur",
          "Solde insuffisant dans le compte pour effectuer l'échange.");

      print("Solde insuffisant dans le compte pour effectuer l'échange.");
      return;
    }

    // Sélectionner un autre compte de destination
    CompteModel compteDestination = comptes.firstWhere(
        (compte) => compte.devise == 'CBC',
        orElse: () => CompteModel(devise: 'CBC', solde: 0));

    bool succes = await compteController.effectuerEchangeAchatCbc(
        compteSource: selectedCompte,
        compteDestination: compteDestination,
        montant: montant,
        tauxEchange: tauxEchange);

    if (succes) {
      _showDialog("Succès", "Échange effectué avec succès !");
      print("Echange effectué avec succès !");
    } else {
      _showDialog("Erreur", "Erreur lors de l'échange.");
      print("Erreur lors de l'échange.");
    }
  }

  // Fonction pour afficher une boîte de dialogue personnalisée
  void _showDialog(String title, String message) {
    showDialog(
      context: context, // Remplacez par le contexte approprié
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Acheter des CBC", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text(
              "Choisir le portefeuille",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                DropdownButton<CompteModel>(
                  value: selectedCompte,
                  dropdownColor: Colors.grey[900],
                  style: TextStyle(color: Colors.white),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
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
                      selectedCompte = value;
                      currentBalance =
                          selectedCompte?.solde ?? 0.0; // Met à jour le solde
                    });
                  },
                ),
                Spacer(),
                Text(
                  "Solde actuel: ${selectedCompte != null ? selectedCompte!.solde!.toStringAsFixed(2) : 0}",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "Montant à utiliser (${selectedCompte?.devise ?? 'N/A'})",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Saisir un montant",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                if (selectedCompte != null) {
                  // Vérifie si selectedCompte est défini
                  _updateCBCAmount(value, selectedCompte!);
                } else {
                  print("Veuillez sélectionner un compte.");
                }
              },
            ),
            SizedBox(height: 25),
            Text(
              "Montant en CBC",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${cbcAmount.toStringAsFixed(2)} CBC",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: selectedCompte == null
                  ? null
                  : () {
                      _acheterCBC(selectedCompte!);
                    },
              child: Text(
                "Acheter ${cbcAmount.toStringAsFixed(2)} CBC",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
