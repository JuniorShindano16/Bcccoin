import 'package:bcccoin/views/operationsViews/acheterCBC.dart';
import 'package:bcccoin/views/operationsViews/autresOperationSp.dart/operations/AutresFacts.dart';
import 'package:bcccoin/views/operationsViews/autresOperationSp.dart/operations/achat.dart';
import 'package:bcccoin/views/operationsViews/autresOperationSp.dart/operations/envoiaAutre.dart';
import 'package:bcccoin/views/operationsViews/autresOperationSp.dart/operations/factureTv.dart';
import 'package:bcccoin/views/operationsViews/depotArgent.dart';
import 'package:bcccoin/views/operationsViews/retraitArgent.dart';
import 'package:flutter/material.dart';

class PaymentInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Effectuer Opération',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle('Effectuer le paiement'),
              SizedBox(height: 12),
              paymentOptionsRow([
                InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              effectuerAChatpage(),
                        ),
                      );
                    },
                    child: buildPaymentOption(
                        icon: Icons.shopping_bag, label: 'Achats')),
                InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => factureTvPage(),
                        ),
                      );
                    },
                    child: buildPaymentOption(
                        icon: Icons.tv, label: 'Facture TV')),
                InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              autreFactureTvPage(),
                        ),
                      );
                    },
                    child: buildPaymentOption(
                        icon: Icons.money, label: 'Autre Facts')),
              ]),
              SizedBox(height: 30),
              sectionTitle("Retirer ou deposer de l'argent"),
              SizedBox(height: 12),
              paymentOptionsRow([
                InkWell(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => RetraitAgentPage(),
                        ),
                      );
                    },
                    child: buildPaymentOption(
                        icon: Icons.store, label: 'Retrait')),
                InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => DepotAgentPage(),
                      ),
                    );
                  },
                  child: buildPaymentOption(
                      icon: Icons.download_rounded, label: 'Dépot'),
                ),
              ]),
              SizedBox(height: 30),
              sectionTitle('Virements bancaires'),
              SizedBox(height: 12),
              paymentOptionsRow([
                InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            envoiversAutreCompte(),
                      ),
                    );
                  },
                  child: buildPaymentOption(
                      icon: Icons.account_balance, label: 'Envoi à autre'),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => AcheterCBCScreen(),
                      ),
                    );
                  },
                  child: buildPaymentOption(
                      icon: Icons.mobile_friendly, label: 'vers portfeuil'),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget paymentOptionsRow(List<Widget> options) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: options
            .map((option) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: option,
                ))
            .toList(),
      ),
    );
  }

  Widget buildPaymentOption({required IconData icon, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 30,
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
