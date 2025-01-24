import 'package:bcccoin/views/operationsViews/acheterCBC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExchangeScreen extends StatefulWidget {
  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  double sellingAmount = 0.04;
  double buyingAmount = 0;
  String selectedCurrency = "CDF"; // Devise sélectionnée par défaut

  // Taux de conversion fictifs pour exemple
  final Map<String, double> exchangeRates = {
    "BTC": 0.1945, // 1 CBC  = 1945 BTC
    "ETH": 1.425, // 1 CBC = 14.25 ETH
    "USD": 2.9815, // 1 CBC = 29,815 USD
    "CDF": 5950, // 1 CBC = 59,500,000 Francs Congolais
  };

  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.text = sellingAmount.toStringAsFixed(2);
  }

  void _updateBuyingAmount(String value) {
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
        buyingAmount = sellingAmount * exchangeRates[selectedCurrency]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
                      Text("MAX 0.49",
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
                          onChanged: _updateBuyingAmount,
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
                          DropdownButton<String>(
                            dropdownColor: Colors.grey[900],
                            value: selectedCurrency,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            underline: SizedBox(),
                            items: exchangeRates.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCurrency = value!;
                                buyingAmount =
                                    sellingAmount * exchangeRates[value]!;
                              });
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
                Text("Taux de change",
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text(
                    "1 CBC = ${exchangeRates[selectedCurrency]?.toStringAsFixed(2)} $selectedCurrency",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
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
              onPressed: () {
                print("Price : " + "$buyingAmount");
              },
              child: Text(
                "Obtenir ${buyingAmount.toStringAsFixed(2)} $selectedCurrency",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
