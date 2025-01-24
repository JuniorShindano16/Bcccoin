import 'package:flutter/material.dart';

class AcheterCBCScreen extends StatefulWidget {
  @override
  _AcheterCBCScreenState createState() => _AcheterCBCScreenState();
}

class _AcheterCBCScreenState extends State<AcheterCBCScreen> {
  double cbcAmount = 0; // Montant de CBC à acheter
  String selectedWallet = "BTC"; // Portefeuille sélectionné par défaut
  double walletBalance = 0; // Solde du portefeuille sélectionné

  // Soldes fictifs pour chaque portefeuille
  final Map<String, double> walletBalances = {
    "BTC": 0.5, // 0.5 BTC disponibles
    "ETH": 10.0, // 10 ETH disponibles
    "USD": 1000.0, // 1000 USD disponibles
    "CDF": 500000.0, // 500 000 CDF disponibles
  };

  // Taux de conversion CBC par devise
  final Map<String, double> AcheterCBCRates = {
    "BTC": 0.1945, // 1 CBC = 0.1945 BTC
    "ETH": 1.425, // 1 CBC = 1.425 ETH
    "USD": 2.9815, // 1 CBC = 2.9815 USD
    "CDF": 5950, // 1 CBC = 5950 CDF
  };

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    walletBalance = walletBalances[selectedWallet]!; // Solde initial
    _amountController.text = "0.00"; // Valeur initiale
  }

  void _updateCBCAmount(String value) {
    if (value.isEmpty) {
      setState(() {
        cbcAmount = 0;
      });
      return;
    }

    final parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue != null) {
      setState(() {
        cbcAmount = parsedValue / AcheterCBCRates[selectedWallet]!;
      });
    }
  }

  void _updateWallet(String wallet) {
    setState(() {
      selectedWallet = wallet;
      walletBalance = walletBalances[wallet]!; // Met à jour le solde
      _updateCBCAmount(_amountController.text); // Recalcule le montant CBC
    });
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
                DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  value: selectedWallet,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  underline: SizedBox(),
                  items: walletBalances.keys.map((String wallet) {
                    return DropdownMenuItem<String>(
                      value: wallet,
                      child: Text(wallet),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) _updateWallet(value);
                  },
                ),
                Spacer(),
                Text(
                  "Solde: ${walletBalance.toStringAsFixed(2)} $selectedWallet",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "Montant à utiliser ($selectedWallet)",
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
              onChanged: _updateCBCAmount,
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
                "${cbcAmount.toStringAsFixed(6)} CBC",
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
              onPressed: () {
                if (cbcAmount > 0 &&
                    walletBalance >= double.parse(_amountController.text)) {
                  print("Achat de $cbcAmount CBC avec $selectedWallet");
                } else {
                  print("Montant insuffisant ou solde indisponible.");
                }
              },
              child: Text(
                "Acheter ${cbcAmount.toStringAsFixed(6)} CBC",
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
