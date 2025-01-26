const String userBox = "userBox";
const String compteBox = "compteBox";
const String transactionCompteBox = "transactionCompteBox";



// // import 'package:bcccoin/controllers/comptController.dart';
// // import 'package:bcccoin/models/TransactionCompteModel.dart';
// // import 'package:bcccoin/models/compteModel.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class CryptoDashboard extends StatefulWidget {
// //   const CryptoDashboard({super.key});

// //   @override
// //   State<CryptoDashboard> createState() => _CryptoDashboardState();
// // }

// // class _CryptoDashboardState extends State<CryptoDashboard> {
// //   int currentPage = 1; // Page courante pour la pagination
// //   int itemsPerPage = 10; // Nombre d'éléments par page
// //   String searchDate = ''; // Filtre de recherche par date
// //   List<CompteModel> comptes = [];
// //   List<TransactionCompteModel> transact = [];
// //   CompteController compteController = Get.put(CompteController());
// //   List<Map<String, dynamic>> structuredTransactions = [];
// //   List<Map<String, dynamic>> displayedTransactions = [];

// //   void loadComptes() {
// //     setState(() {
// //       transact = compteController.transactionCompteBoxe.values.toList();
// //       comptes = compteController.compteBoxe.values.toList();

// //       structuredTransactions = buildStructuredTransactionList();
// //       filterAndPaginateTransactions();
// //     });
// //   }

// //   List<Map<String, dynamic>> buildStructuredTransactionList() {
// //     List<Map<String, dynamic>> structuredList = [];

// //     for (var transaction in transact) {
// //       CompteModel? compteSource = comptes.firstWhere(
// //         (compte) => compte.id == transaction.compteSourceId,
// //         orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
// //       );

// //       CompteModel? compteDestination = comptes.firstWhere(
// //         (compte) => compte.id == transaction.compteDestinationId,
// //         orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
// //       );

// //       if (compteSource != null && compteDestination != null) {
// //         structuredList.add({
// //           'compteSource': compteSource,
// //           'compteDestination': compteDestination,
// //           'montantTransaction': transaction.montantTransaction,
// //           'date': transaction.date,
// //         });
// //       }
// //     }

// //     return structuredList;
// //   }

// //   void filterAndPaginateTransactions() {
// //     List<Map<String, dynamic>> filteredTransactions = structuredTransactions;

// //     if (searchDate.isNotEmpty) {
// //       filteredTransactions = structuredTransactions.where((transaction) {
// //         String transactionDate =
// //             transaction['date'].toString().substring(0, 10);
// //         return transactionDate == searchDate;
// //       }).toList();
// //     }

// //     int startIndex = (currentPage - 1) * itemsPerPage;
// //     int endIndex = startIndex + itemsPerPage;

// //     setState(() {
// //       displayedTransactions = filteredTransactions
// //           .sublist(
// //             startIndex,
// //             endIndex > filteredTransactions.length
// //                 ? filteredTransactions.length
// //                 : endIndex,
// //           )
// //           .toList();
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadComptes();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         backgroundColor: Colors.black,
// //         elevation: 0,
// //         title: const Text(
// //           'Transactions',
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Zone de recherche
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: TextField(
// //               style: const TextStyle(color: Colors.white),
// //               decoration: InputDecoration(
// //                 hintText: 'Rechercher par date (YYYY-MM-DD)',
// //                 hintStyle: const TextStyle(color: Colors.grey),
// //                 filled: true,
// //                 fillColor: Colors.grey.shade800,
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(12),
// //                   borderSide: BorderSide.none,
// //                 ),
// //               ),
// //               onChanged: (value) {
// //                 searchDate = value;
// //                 currentPage = 1; // Réinitialiser la pagination
// //                 filterAndPaginateTransactions();
// //               },
// //             ),
// //           ),

// //           // Liste des transactions
// //           Expanded(
// //             child: Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade900,
// //                 borderRadius:
// //                     const BorderRadius.vertical(top: Radius.circular(16)),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text(
// //                     'Transactions',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 16),

// //                   // Liste dynamique des transactions
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: displayedTransactions.length,
// //                       itemBuilder: (context, index) {
// //                         final transaction = displayedTransactions[index];
// //                         final CompteModel source = transaction['compteSource'];
// //                         final CompteModel destination =
// //                             transaction['compteDestination'];
// //                         final double amount = transaction['montantTransaction'];
// //                         final DateTime date = transaction['date'];

// //                         return Container(
// //                           margin: const EdgeInsets.only(bottom: 16),
// //                           padding: const EdgeInsets.all(12),
// //                           decoration: BoxDecoration(
// //                             color: Colors.grey.shade800,
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   const Icon(Icons.swap_horiz,
// //                                       color: Colors.orange),
// //                                   const SizedBox(width: 8),
// //                                   Expanded(
// //                                     child: Text(
// //                                       '${source.name} → ${destination.name}',
// //                                       style: const TextStyle(
// //                                         color: Colors.white,
// //                                         fontWeight: FontWeight.bold,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Text(
// //                                 'Amount: $amount ${source.devise}',
// //                                 style: const TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 4),
// //                               Text(
// //                                 'Date: ${date.toLocal()}',
// //                                 style: TextStyle(
// //                                   color: Colors.grey.shade400,
// //                                   fontSize: 12,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),

// //                   // Pagination
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       IconButton(
// //                         icon: const Icon(Icons.arrow_back, color: Colors.white),
// //                         onPressed: currentPage > 1
// //                             ? () {
// //                                 setState(() {
// //                                   currentPage--;
// //                                   filterAndPaginateTransactions();
// //                                 });
// //                               }
// //                             : null,
// //                       ),
// //                       Text(
// //                         'Page $currentPage',
// //                         style: const TextStyle(color: Colors.white),
// //                       ),
// //                       IconButton(
// //                         icon: const Icon(Icons.arrow_forward,
// //                             color: Colors.white),
// //                         onPressed: (currentPage * itemsPerPage) <
// //                                 structuredTransactions.length
// //                             ? () {
// //                                 setState(() {
// //                                   currentPage++;
// //                                   filterAndPaginateTransactions();
// //                                 });
// //                               }
// //                             : null,
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:bcccoin/controllers/comptController.dart';
// import 'package:bcccoin/models/TransactionCompteModel.dart';
// import 'package:bcccoin/models/compteModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CryptoDashboard extends StatefulWidget {
//   const CryptoDashboard({super.key});

//   @override
//   State<CryptoDashboard> createState() => _CryptoDashboardState();
// }

// class _CryptoDashboardState extends State<CryptoDashboard> {
//   int selectedTab = 0;
//   List<CompteModel> comptes = [];
//   List<TransactionCompteModel> transact = [];
//   List<Map<String, dynamic>> structuredTransactions = [];
//   List<Map<String, dynamic>> filteredTransactions = [];
//   int currentPage = 0;
//   final int itemsPerPage = 10;
//   DateTime? selectedDate;
//   CompteController compteController = Get.put(CompteController());

//   void loadComptes() {
//     setState(() {
//       transact = compteController.transactionCompteBoxe.values.toList();
//       comptes = compteController.compteBoxe.values.toList();
//       structuredTransactions = buildStructuredTransactionList();
//       filteredTransactions = structuredTransactions;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadComptes();
//   }

//   List<Map<String, dynamic>> buildStructuredTransactionList() {
//     List<Map<String, dynamic>> structuredList = [];

//     for (var transaction in transact) {
//       CompteModel? compteSource = comptes.firstWhere(
//         (compte) => compte.id == transaction.compteSourceId,
//         orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
//       );

//       CompteModel? compteDestination = comptes.firstWhere(
//         (compte) => compte.id == transaction.compteDestinationId,
//         orElse: () => CompteModel(name: '', devise: 'CBC', solde: 0.0),
//       );

//       if (compteSource != null && compteDestination != null) {
//         structuredList.add({
//           'compteSource': compteSource,
//           'compteDestination': compteDestination,
//           'montantTransaction': transaction.montantTransaction,
//           'date': transaction.date,
//         });
//       }
//     }

//     return structuredList;
//   }

//   void filterTransactionsByDate(DateTime? date) {
//     if (date != null) {
//       setState(() {
//         selectedDate = date;
//         filteredTransactions = structuredTransactions.where((transaction) {
//           final transactionDate = transaction['date'] as DateTime;
//           return transactionDate.year == date.year &&
//               transactionDate.month == date.month &&
//               transactionDate.day == date.day;
//         }).toList();
//         currentPage = 0; // Reset pagination
//       });
//     }
//   }

//   void selectDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.dark(
//               primary: Colors.orange,
//               onPrimary: Colors.white,
//               surface: Colors.grey,
//               onSurface: Colors.white,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     filterTransactionsByDate(pickedDate);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final paginatedTransactions = filteredTransactions
//         .skip(currentPage * itemsPerPage)
//         .take(itemsPerPage)
//         .toList();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const Text(
//           'Transactions',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Sélecteur de date
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: InkWell(
//               onTap: selectDate,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade800,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.calendar_today, color: Colors.orange),
//                     const SizedBox(width: 8),
//                     Text(
//                       selectedDate != null
//                           ? 'Transactions du : ${selectedDate!.toLocal()}'
//                               .split(' ')[0]
//                           : 'Sélectionner une date',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Liste paginée des transactions
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade900,
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: paginatedTransactions.length,
//                       itemBuilder: (context, index) {
//                         final transaction = paginatedTransactions[index];
//                         final CompteModel source = transaction['compteSource'];
//                         final CompteModel destination =
//                             transaction['compteDestination'];
//                         final double amount = transaction['montantTransaction'];
//                         final DateTime date = transaction['date'];

//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 16),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade800,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(Icons.swap_horiz, color: Colors.orange),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: Text(
//                                       '${source.name} → ${destination.name}',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Montant: $amount ${source.devise}',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Date: ${date.toLocal()}'.split(' ')[0],
//                                 style: TextStyle(
//                                   color: Colors.grey.shade400,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Pagination controls
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: currentPage > 0
//                             ? () {
//                                 setState(() {
//                                   currentPage--;
//                                 });
//                               }
//                             : null,
//                         child: const Text('Précédent'),
//                       ),
//                       ElevatedButton(
//                         onPressed: (currentPage + 1) * itemsPerPage <
//                                 filteredTransactions.length
//                             ? () {
//                                 setState(() {
//                                   currentPage++;
//                                 });
//                               }
//                             : null,
//                         child: const Text('Suivant'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }