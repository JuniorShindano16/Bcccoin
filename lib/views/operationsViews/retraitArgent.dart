// import 'package:flutter/material.dart';

// class RetraitAgentPage extends StatefulWidget {
//   @override
//   _RetraitAgentPageState createState() => _RetraitAgentPageState();
// }

// class _RetraitAgentPageState extends State<RetraitAgentPage> {
//   TextEditingController numberAgentController = TextEditingController();

//   bool isButtonActive = false;
//   String selectedCurrency = 'CDF'; // Devise sélectionnée par défaut
//   double currentBalance = 35466.0; // Solde par défaut pour CDF
//   List<double> quickAmounts = [
//     10000,
//     20000,
//     50000,
//     100000
//   ]; // Montants rapides pour CDF

//   TextEditingController montantController = TextEditingController();

//   // Fonction pour mettre à jour les données selon la devise choisie
//   void updateCurrency(String currency) {
//     setState(() {
//       selectedCurrency = currency;
//       if (currency == 'CDF') {
//         currentBalance = 35466.0;
//         quickAmounts = [10000, 20000, 50000, 100000];
//       } else if (currency == 'USD') {
//         currentBalance = 100.0;
//         quickAmounts = [10, 20, 50, 100];
//       }
//     });
//   }

//   // Fonction pour mettre à jour le champ de texte avec le montant rapide
//   void updateAmount(double amount) {
//     setState(() {
//       montantController.text = amount.toStringAsFixed(2);
//     });
//   }

//   // Fonction pour valider le formulaire
//   void validateForm() {
//     setState(() {
//       isButtonActive = montantController.text.isNotEmpty &&
//           numberAgentController.text.isNotEmpty;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     montantController.addListener(
//         validateForm); // Ajoute un listener pour surveiller les changements
//     numberAgentController.addListener(validateForm);
//   }

//   @override
//   void dispose() {
//     montantController.dispose();
//     numberAgentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: Text(
//           "Retrait auprès d'un Agent",
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Icon(Icons.more_vert, color: Colors.white),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Card principale
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Titre avec Dropdown
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Retrait de: ",
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         DropdownButton<String>(
//                           value: selectedCurrency,
//                           dropdownColor: Colors.grey[900],
//                           style: TextStyle(color: Colors.white),
//                           icon:
//                               Icon(Icons.arrow_drop_down, color: Colors.white),
//                           items: [
//                             DropdownMenuItem(
//                               value: 'CDF',
//                               child: Text('CDF compte'),
//                             ),
//                             DropdownMenuItem(
//                               value: 'USD',
//                               child: Text('USD compte'),
//                             ),
//                           ],
//                           onChanged: (value) {
//                             if (value != null) updateCurrency(value);
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     // Numéro Agent
//                     TextField(
//                       controller: numberAgentController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Numéro Agent",
//                         labelStyle: TextStyle(color: Colors.grey),
//                         filled: true,
//                         fillColor: Colors.grey[850],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffixIcon:
//                             Icon(Icons.calendar_today, color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     // Montant
//                     TextField(
//                       controller: montantController,
//                       style: TextStyle(color: Colors.white),
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: "Montant",
//                         labelStyle: TextStyle(color: Colors.grey),
//                         filled: true,
//                         fillColor: Colors.grey[850],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffix: Text(
//                           "Solde actuel: ${currentBalance.toStringAsFixed(2)} $selectedCurrency",
//                           style: TextStyle(color: Colors.green, fontSize: 14),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     // Boutons de montant rapide
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: quickAmounts.map((amount) {
//                         return _buildQuickAmountButton(amount);
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 50),
//               // Bouton Continuer
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: isButtonActive
//                       ? () {
//                           // Action du bouton
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: isButtonActive
//                         ? Colors.green
//                         : Colors.grey[700], // Couleur grisée si inactif
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text(
//                     "Continuer",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickAmountButton(double amount) {
//     return ElevatedButton(
//       onPressed: () => updateAmount(amount),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.grey[850],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12),
//       ),
//       child: Text(
//         "${amount.toStringAsFixed(1)} $selectedCurrency",
//         style: TextStyle(color: Colors.white, fontSize: 8),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RetraitAgentPage extends StatefulWidget {
  @override
  _RetraitAgentPageState createState() => _RetraitAgentPageState();
}

class _RetraitAgentPageState extends State<RetraitAgentPage> {
  String selectedCurrency = 'CDF'; // Devise sélectionnée par défaut
  double currentBalance = 35466.0; // Solde par défaut pour CDF
  List<double> quickAmounts = [
    10000,
    20000,
    50000,
    100000
  ]; // Montants rapides pour CDF

  TextEditingController montantController = TextEditingController();
  TextEditingController numeroAgentController = TextEditingController();
  bool isButtonActive = false; // Bouton "Continuer" actif ou inactif

  // Fonction pour mettre à jour les données selon la devise choisie
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

  // Fonction pour mettre à jour le champ de texte avec le montant rapide
  void updateAmount(double amount) {
    setState(() {
      montantController.text = amount.toStringAsFixed(2);
      validateForm(); // Vérifie si les champs sont remplis
    });
  }

  // Fonction pour valider le formulaire
  void validateForm() {
    setState(() {
      isButtonActive = montantController.text.isNotEmpty &&
          numeroAgentController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    montantController.addListener(
        validateForm); // Ajoute un listener pour surveiller les changements
    numeroAgentController.addListener(validateForm);
  }

  @override
  void dispose() {
    montantController.dispose();
    numeroAgentController.dispose();
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
          "Retrait auprès d'un Agent",
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
                          "Retrait de: ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: selectedCurrency,
                          dropdownColor: Colors.grey[900],
                          style: TextStyle(color: Colors.white),
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.white),
                          items: [
                            DropdownMenuItem(
                              value: 'CDF',
                              child: Text('CDF compte'),
                            ),
                            DropdownMenuItem(
                              value: 'USD',
                              child: Text('USD compte'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) updateCurrency(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Numéro Agent
                    TextField(
                      controller: numeroAgentController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Numéro Agent",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon:
                            Icon(Icons.calendar_today, color: Colors.white),
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
                          "Solde actuel: ${currentBalance.toStringAsFixed(2)} $selectedCurrency",
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
                          // Action du bouton
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
        "${amount.toStringAsFixed(1)} $selectedCurrency",
        style: TextStyle(color: Colors.white, fontSize: 8),
      ),
    );
  }
}
