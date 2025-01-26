import 'package:bcccoin/controllers/userController.dart';
import 'package:bcccoin/utils/setting.dart';
import 'package:bcccoin/views/auth/register.dart';
import 'package:bcccoin/widgets/BottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  final UserController _userController = Setting.User_controller;
  bool loading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Numéro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: numberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Entrez votre numéro',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Mot de passe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Entrez votre mot de passe',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });

                                final bool rs = await _userController.loginUser(
                                  numberController.text,
                                  passwordController.text,
                                );

                                if (rs) {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await Get.defaultDialog(
                                    title: "Connexion réussie",
                                    titleStyle: const TextStyle(
                                      color: Color.fromARGB(255, 13, 110, 253),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    middleText: 'Bienvenue sur la plateforme',
                                    middleTextStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 18,
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(221, 75, 75, 75),
                                    radius: 15,
                                    contentPadding: const EdgeInsets.all(20),
                                    barrierDismissible: false,
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    buttonColor: Colors.green,
                                    onConfirm: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const Bottomngnavbarre()),
                                      );
                                    },
                                    content: Column(
                                      children: [
                                        const Icon(
                                          Icons.check_circle_outline,
                                          color:
                                              Color.fromARGB(255, 13, 110, 253),
                                          size: 50,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Bienvenue sur la plateforme',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const Bottomngnavbarre()),
                                  );

                                  setState(() {
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.defaultDialog(
                                    title: "Erreur",
                                    titleStyle: const TextStyle(
                                      color: Color.fromARGB(255, 13, 110, 253),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    middleText: "Identifiants incorrects",
                                    middleTextStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 18,
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(221, 75, 75, 75),
                                    radius: 15,
                                    contentPadding: const EdgeInsets.all(20),
                                    barrierDismissible: false,
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    buttonColor: Colors.green,
                                    onConfirm: () {
                                      Get.back();
                                    },
                                    content: Column(
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          color:
                                              Color.fromARGB(255, 13, 110, 253),
                                          size: 50,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Identifiants incorrects",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                print("Numéro: ${numberController.text}");
                                print(
                                    "Mot de passe: ${passwordController.text}");
                              },
                              child: const Text(
                                'Se connecter',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterUi(),

                            // AcheterCBCScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Vous inscrire ?',
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
