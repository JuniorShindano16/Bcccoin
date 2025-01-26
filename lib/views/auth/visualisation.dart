import 'package:bcccoin/views/auth/login.dart';
import 'package:bcccoin/widgets/BottomAppBar.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String country;
  final String number;
  final String avenue;
  final String quartier;
  final String commune;

  NextPage({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.number,
    required this.avenue,
    required this.quartier,
    required this.commune,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Aperçu de votre formulaire',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vos informations',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              SizedBox(height: 20),
              buildSectionHeader('Informations personnelles'),
              buildEditableRow(
                context,
                title: 'NOMS',
                value: name,
              ),
              buildEditableRow(
                context,
                title: 'Téléphone',
                value: phone,
              ),
              buildEditableRow(
                context,
                title: 'Email',
                value: email,
              ),
              buildSectionHeader('Adresse'),
              buildEditableRow(
                context,
                title: 'Pays',
                value: country,
              ),
              buildEditableRow(
                context,
                title: 'Avenue',
                value: avenue,
              ),
              buildEditableRow(
                context,
                title: 'Quartier',
                value: quartier,
              ),
              buildEditableRow(
                context,
                title: 'Commune',
                value: commune,
              ),
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Compte créé , connectez vous maintenant')),
                      );
                    },
                    child: Text('Soumettre'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Couleur personnalisée
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableRow(BuildContext context,
      {required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value.isNotEmpty ? value : 'Pas de reponse',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Divider(),
        ],
      ),
    );
  }
}
