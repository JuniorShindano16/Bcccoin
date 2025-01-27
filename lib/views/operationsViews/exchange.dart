import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/controllers/userController.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:bcccoin/models/userModel.dart';
import 'package:bcccoin/views/auth/login.dart';
import 'package:bcccoin/views/auth/register.dart';
import 'package:bcccoin/views/operationsViews/acheterCBC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  final UserController userController = Get.put(UserController());
  CompteController compteController = Get.put(CompteController());
  List<CompteModel> comptes = [];
  List<CompteModel> comptesTop = [];
  CompteModel? selectedCompte;
  CompteModel? CompteCBC;
  double tauxEchange = 1;

  double? sellingAmount = 0;
  double buyingAmount = 0;
  String selectedCurrency = "CDF"; // Devise sélectionnée par défaut

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = "0.00"; // Valeur initiale
    loadComptes();
    assignCompteCBC();
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

      // Affiche les détails pour vérifier
      print(
          "Comptes chargés : ${comptes.map((c) => '${c.name} (${c.devise}) ${c.solde}').toList()}");
      print(
          "Comptes filtrés (CDF et USD) : ${comptesTop.map((c) => '${c.name} (${c.devise})').toList()}");
    });
  }

  void _updateBuyingAmount(String value, CompteModel selected) {
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
        buyingAmount = 0;
      });
      return;
    }

    final parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue != null) {
      setState(() {
        sellingAmount = parsedValue;
        buyingAmount = sellingAmount! * tauxEchange;
      });
    }
  }

  void assignCompteCBC() {
    setState(() {
      CompteCBC = comptes.firstWhere(
        (compte) => compte.devise == 'CBC',
        orElse: () => CompteModel(
            name: '', devise: 'CBC', solde: 0.0), // Objet par défaut
      );
    });
  }

  void _acheterCBC(
    CompteModel selectedCompte,
  ) async {
    assignCompteCBC();

    double montant = sellingAmount!;
    double tauxEchange = 1;

    if (selectedCompte == null) {
      _showDialog("Erreur", "Veuillez sélectionner un compte.");
      return;
    }

    if (montant <= 0) {
      _showDialog("Erreur", "Montant invalide pour l'achat.");
      return;
    }

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
        return;
    }

    if (CompteCBC!.solde! < montant) {
      _showDialog("Erreur",
          "Solde insuffisant dans le compte pour effectuer l'échange.");
      return;
    }

    bool succes = await compteController.effectuerEchangeAutre(
      compteSource: CompteCBC!,
      compteDestination: selectedCompte,
      montant: montant,
      tauxEchange: tauxEchange,
    );

    if (succes) {
      _showDialog("Succès", "Échange effectué avec succès !");
    } else {
      _showDialog("Erreur", "Erreur lors de l'échange.");
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

  void _updateTauxEchange(CompteModel compte) {
    setState(() {
      switch (compte.devise) {
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
          tauxEchange = 0; // Valeur par défaut si devise non gérée
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = userController.getUserModel();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Acheter Devise avec CBC",
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        // Rendre le contenu scrollable
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Selling
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Se ravitailler en CBC",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    print("User" + "${user?.name}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AcheterCBCScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.wallet_rounded,
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CRYPTO",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text("MAX ${CompteCBC!.solde!.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text("B",
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 8),
                          Text("CBC",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: _amountController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                          onChanged: (value) {
                            if (selectedCompte != null) {
                              _updateBuyingAmount(value, selectedCompte!);
                            } else {
                              print("Veuillez sélectionner un compte.");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Icon(Icons.swap_vert, color: Colors.white, size: 32),
            ),
            SizedBox(height: 16),
            // Section Buying
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ACHAT",
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Text(selectedCurrency[0],
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 8),
                          DropdownButton<CompteModel>(
                            dropdownColor: Colors.grey[900],
                            value: selectedCompte,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            underline: SizedBox(),
                            items: comptesTop.map((compte) {
                              return DropdownMenuItem<CompteModel>(
                                  value: compte,
                                  child: Text(
                                    compte.name ?? 'Compte inconnu',
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              _updateTauxEchange(value!);
                              setState(() {
                                selectedCompte = value;
                                buyingAmount = sellingAmount! * tauxEchange;
                                print(buyingAmount);
                                print(sellingAmount);
                              });
                              // Met à jour le taux
                            },
                          ),
                        ],
                      ),
                      Text(buyingAmount.toStringAsFixed(2),
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Rate and Exchange Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Taux de change",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  selectedCompte != null
                      ? "1 CBC = ${tauxEchange.toStringAsFixed(2)} ${selectedCompte!.devise}"
                      : "Sélectionnez un compte",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Frais d'échange",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text("GRATUIT",
                    style: TextStyle(color: Colors.green, fontSize: 14)),
              ],
            ),
            SizedBox(height: 16),
            // Button
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
                      print("Price : " + "$buyingAmount");
                    },
              child: Text(
                "Obtenir ${buyingAmount.toStringAsFixed(2)} ${selectedCompte?.devise}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
