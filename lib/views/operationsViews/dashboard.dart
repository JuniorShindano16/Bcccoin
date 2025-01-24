import 'package:flutter/material.dart';

class CryptoDashboard extends StatefulWidget {
  const CryptoDashboard({super.key});

  @override
  State<CryptoDashboard> createState() => _CryptoDashboardState();
}

class _CryptoDashboardState extends State<CryptoDashboard> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Transactions',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for the chart
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Chart Placeholder',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          // Timeframe tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 6; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = i;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedTab == i
                            ? Colors.green
                            : Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ['1D', '1W', '1M', '3M', '6M', '1Y'][i],
                        style: TextStyle(
                          color: selectedTab == i ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('Buy',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('Exchange',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: const Text('Sell',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          // Transactions list
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
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.currency_bitcoin, color: Colors.orange),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '0.025 BTC',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      const Text(
                        '\$745.41',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    children: [
                      Icon(Icons.currency_exchange, color: Colors.green),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '0.39 ETH',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      const Text(
                        '\$738.08',
                        style: TextStyle(color: Colors.white, fontSize: 14),
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
