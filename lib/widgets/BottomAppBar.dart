import 'dart:ui';
import 'package:bcccoin/views/home.dart';
import 'package:bcccoin/views/operationsViews/autresOperationSp.dart/operationsHome.dart';
import 'package:bcccoin/views/operationsViews/dashboard.dart';
import 'package:bcccoin/views/operationsViews/exchange.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Bottomngnavbarre extends StatefulWidget {
  const Bottomngnavbarre({super.key});

  @override
  State<Bottomngnavbarre> createState() => _BottomngnavbarreState();
}

class _BottomngnavbarreState extends State<Bottomngnavbarre> {
  int index = 0;
  List<Widget> sreensList = [
    PortfolioScreen(),
    ExchangeScreen(),
    PaymentInterface(),
    CryptoDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fond noir
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3), // Légère lueur verte
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: GNav(
            backgroundColor: Colors.black, // Fond noir
            color:
                Colors.green.withOpacity(0.7), // Icones inactives (vert clair)
            activeColor:
                Colors.black, // Couleur texte actif (noir sur fond vert)
            tabBackgroundColor: Colors.green, // Onglet actif (vert intense)
            tabBorderRadius: 12, // Coins arrondis
            gap: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            onTabChange: (index) {
              setState(() {
                this.index = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                text: 'Home',
                iconSize: 24,
                textStyle: TextStyle(
                  color: Colors.black, // Texte sur fond vert (onglet actif)
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.shopping_basket_outlined,
                text: 'Marché',
                iconSize: 24,
                textStyle: TextStyle(
                  color: Colors.black, // Texte sur fond vert (onglet actif)
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.calculate,
                text: 'XY',
                iconSize: 24,
                textStyle: TextStyle(
                  color: Colors.black, // Texte sur fond vert (onglet actif)
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.currency_exchange,
                text: 'Trans',
                iconSize: 24,
                textStyle: TextStyle(
                  color: Colors.black, // Texte sur fond vert (onglet actif)
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: sreensList[index],
    );
  }
}
