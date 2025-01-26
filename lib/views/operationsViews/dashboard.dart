import 'dart:math';

import 'package:bcccoin/controllers/comptController.dart';
import 'package:bcccoin/models/TransactionCompteModel.dart';
import 'package:bcccoin/models/compteModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoDashboard extends StatefulWidget {
  const CryptoDashboard({super.key});

  @override
  State<CryptoDashboard> createState() => _CryptoDashboardState();
}

class _CryptoDashboardState extends State<CryptoDashboard> {
  int currentPage = 1; // Page courante pour la pagination
  int itemsPerPage = 10; // Nombre d'éléments par page
  DateTime? selectedDate; // Date sélectionnée via le calendrier
  List<CompteModel> comptes = [];
  List<TransactionCompteModel> transact = [];
  CompteController compteController = Get.put(CompteController());
  List<Map<String, dynamic>> structuredTransactions = [];
  List<Map<String, dynamic>> displayedTransactions = [];

  void loadComptes() {
    setState(() {
      transact = compteController.transactionCompteBoxe.values.toList();
      comptes = compteController.compteBoxe.values.toList();

      structuredTransactions = buildStructuredTransactionList();
      filterAndPaginateTransactions();
    });
  }

  List<Map<String, dynamic>> buildStructuredTransactionList() {
    List<Map<String, dynamic>> structuredList = [];

    for (var transaction in transact) {
      CompteModel? compteSource = comptes.firstWhere(
        (compte) => compte.id == transaction.compteSourceId,
        orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
      );

      CompteModel? compteDestination = comptes.firstWhere(
        (compte) => compte.id == transaction.compteDestinationId,
        orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
      );

      String? idAgent = transaction.idAgent;

      if (compteSource != null && compteDestination != null) {
        structuredList.add({
          'compteSource': compteSource,
          'compteDestination': compteDestination,
          'montantTransaction': transaction.montantTransaction,
          'date': transaction.date,
          'idAgent': idAgent
        });
      }
    }

    return structuredList;
  }

  void filterAndPaginateTransactions() {
    List<Map<String, dynamic>> filteredTransactions = structuredTransactions;

    if (selectedDate != null) {
      String formattedDate = selectedDate!.toIso8601String().substring(0, 10);
      filteredTransactions = structuredTransactions.where((transaction) {
        String transactionDate =
            transaction['date'].toString().substring(0, 10);
        return transactionDate == formattedDate;
      }).toList();
    }

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;

    setState(() {
      displayedTransactions = filteredTransactions
          .sublist(
            startIndex,
            endIndex > filteredTransactions.length
                ? filteredTransactions.length
                : endIndex,
          )
          .toList();
    });
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // Personnalisation du thème du calendrier
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        currentPage = 1; // Réinitialiser la pagination
        filterAndPaginateTransactions();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadComptes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Zone de recherche avec sélection de date
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 10),
                    Text(
                      selectedDate == null
                          ? 'Sélectionnez une date'
                          : 'Date : ${selectedDate!.toLocal()}'
                              .substring(0, 16),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Liste des transactions
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Liste dynamique des transactions
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = displayedTransactions[index];
                        final CompteModel source = transaction['compteSource'];
                        final CompteModel destination =
                            transaction['compteDestination'];
                        final double amount = transaction['montantTransaction'];
                        final DateTime date = transaction['date'];
                        final String? agent =
                            transaction['idAgent'] ?? (randomString(length: 8));

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.swap_horiz,
                                      color: Colors.green),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${source.name} → ${destination.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Montant: $amount ${source.devise}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tiers Utilisé: ${agent}',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Date: ${date.toLocal()}',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Pagination
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: currentPage > 1
                            ? () {
                                setState(() {
                                  currentPage--;
                                  filterAndPaginateTransactions();
                                });
                              }
                            : null,
                      ),
                      Text(
                        'Page $currentPage',
                        style: const TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        onPressed: (currentPage * itemsPerPage) <
                                structuredTransactions.length
                            ? () {
                                setState(() {
                                  currentPage++;
                                  filterAndPaginateTransactions();
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String randomString({required int length}) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_/-%^@';
  final random = Random();

  return List.generate(
      length, (index) => characters[random.nextInt(characters.length)]).join();
}
