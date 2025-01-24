import 'package:bcccoin/views/operationsViews/depotArgent.dart';
import 'package:bcccoin/views/operationsViews/retraitArgent.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String selectedTab = "Mois"; // Onglet sélectionné par défaut
  List<FlSpot> chartData = []; // Données du graphique

  double get minY => chartData.isNotEmpty
      ? chartData.map((e) => e.y).reduce((a, b) => a < b ? a : b)
      : 0;
  double get maxY => chartData.isNotEmpty
      ? chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b)
      : 100;

  double get minX => chartData.isNotEmpty
      ? chartData.map((e) => e.x).reduce((a, b) => a < b ? a : b)
      : 0;
  double get maxX => chartData.isNotEmpty
      ? chartData.map((e) => e.x).reduce((a, b) => a > b ? a : b)
      : 1;

  @override
  void initState() {
    super.initState();
    _updateChartData("Mois"); // Initialisation des données pour "6M"
  }

// Met à jour les données en fonction du filtre
  void _updateChartData(String filter) {
    setState(() {
      switch (filter) {
        case "Jour":
          chartData = [
            FlSpot(0, 1000),
            FlSpot(4, 1020),
            FlSpot(8, 1010),
            FlSpot(12, 1035),
            FlSpot(16, 1025),
            FlSpot(20, 1040),
            FlSpot(24, 1030),
          ];
          break;
        case "Mois":
          chartData = [
            FlSpot(0, 1000),
            FlSpot(1, 1020),
            FlSpot(2, 1015),
            FlSpot(3, 1030),
            FlSpot(4, 1025),
            FlSpot(5, 1045),
            FlSpot(6, 1050),
          ];
          break;
        case "Semaine":
          chartData = [
            FlSpot(2, 1000),
            FlSpot(5, 1010),
            FlSpot(10, 1030),
            FlSpot(15, 1045),
            FlSpot(20, 1060),
            FlSpot(25, 1075),
            FlSpot(30, 1055),
          ];
          break;
        case "Trimestre":
          chartData = [
            FlSpot(0, 950),
            FlSpot(15, 1000),
            FlSpot(30, 1050),
            FlSpot(45, 1100),
            FlSpot(60, 1150),
            FlSpot(75, 1130),
            FlSpot(90, 1180),
          ];
          break;
        case "Semestre":
          chartData = [
            FlSpot(0, 900),
            FlSpot(30, 950),
            FlSpot(60, 1000),
            FlSpot(90, 1050),
            FlSpot(120, 1100),
            FlSpot(150, 1080),
            FlSpot(180, 1120),
          ];
          break;
        case "Année":
          chartData = [
            FlSpot(0, 850),
            FlSpot(60, 900),
            FlSpot(120, 950),
            FlSpot(180, 1000),
            FlSpot(240, 1050),
            FlSpot(300, 1080),
            FlSpot(360, 1100),
          ];
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Photo de profil
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ralph Edwards",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Profile >",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.notifications_none, color: Colors.white),
                SizedBox(width: 10),
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Solde et graphique
            SizedBox(height: 20),
            Text(
              "Votre Balance",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CBC 33648.43",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "+CBC 18.00 (+10.9%)",
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                RetraitAgentPage(),
                          ),
                        );
                        // Get.off(RetraitAgentPage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          'assets/moneyup.png', // Chemin vers l'image pour le retrait
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => DepotAgentPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          'assets/moneydown.png', // Chemin vers l'image pour le dépôt
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Tendance de la monnaie",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        // showTitles: true,
                        reservedSize: 28,
                        // interval: 10000,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 1:
                              return Text('',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12));
                            case 3:
                              return Text('',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12));
                            case 6:
                              return Text('',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12));
                            case 9:
                              return Text('',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12));
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  minX: minX,
                  maxX: maxX,
                  minY: minY,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.green
                        ], // Peut contenir plusieurs couleurs pour un dégradé
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.3),
                            Colors.green.withOpacity(0.1)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTab("Jour"),
                  SizedBox(width: 5),
                  _buildTab("Semaine"),
                  SizedBox(width: 5),
                  _buildTab("Mois"),
                  SizedBox(width: 5),
                  _buildTab("Trimestre"),
                  SizedBox(width: 5),
                  _buildTab("Semestre"),
                  SizedBox(width: 5),
                  _buildTab("Année"),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Portfolio Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Autre crypto",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Valeur en \$",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildPortfolioItem(
                    "Ethereum", "ETH", "3.13", "\$24,849.71", Colors.blue),
                _buildPortfolioItem(
                    "Bitcoin", "BTC", "0.49", "\$14,609.69", Colors.orange),
                _buildPortfolioItem("Polygon", "MATIC", "13,370.64",
                    "\$10,305.42", Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    bool isSelected = selectedTab == label; // Vérifie si c'est l'onglet actif
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
          _updateChartData(label); // Met à jour les données du graphique
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.green : Colors.grey[800], // Indicateur visuel
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Widget _buildTab(String label) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedTab = label;
  //         _updateChartData(label); // Met à jour les données du graphique
  //       });
  //     },
  //     child: Text(
  //       label,
  //       style: TextStyle(
  //         color: selectedTab == label ? Colors.white : Colors.grey,
  //         fontSize: 14,
  //         fontWeight:
  //             selectedTab == label ? FontWeight.bold : FontWeight.normal,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildTab(String label) {

  Widget _buildPortfolioItem(
      String name, String symbol, String quantity, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Text(
                  symbol[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    symbol,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                quantity,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
