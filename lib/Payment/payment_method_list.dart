import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentMethodList extends StatelessWidget {
  const PaymentMethodList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Subheading
            const Text(
              'Reserve ride points for hassle-free ride payment. It will be immediately refunded in case of unjoin or cancellation.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16.0),

            // Quick Ride Wallet Option
            ListTile(
              leading:
                  const Icon(Icons.account_balance_wallet, color: Colors.green),
              title: const Text('Quick Ride Wallet'),
              subtitle: const Text('DEFAULT ₹0 Add Money',
                  style: TextStyle(color: Colors.grey)),
              trailing:
                  IconButton(icon: Icon(Icons.navigate_next), onPressed: () {}),
              onTap: () {
                if (kDebugMode) {
                  print('Quick Ride Wallet tapped');
                }
              },
            ),

            // Pay Later Option
            ListTile(
              leading: Icon(Icons.timer, color: Colors.blue),
              title: Text('Pay Later'),
              subtitle: Text('Simpl', style: TextStyle(color: Colors.grey)),
              trailing:
                  IconButton(icon: Icon(Icons.navigate_next), onPressed: () {}),
              onTap: () {
                if (kDebugMode) {
                  print('Pay Later tapped');
                }
              },
            ),

            // Wallets/Gift Cards Option
            ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.purple),
              title: Text('Wallets/Gift Cards'),
              subtitle: Text('Paytm, Amazon Pay, Mobikwik, Freecharge',
                  style: TextStyle(color: Colors.grey)),
              trailing:
                  IconButton(icon: Icon(Icons.navigate_next), onPressed: () {}),
              onTap: () {
                if (kDebugMode) {
                  print('Wallets/Gift Cards tapped');
                }
              },
            ),

            // Add more ListTiles for other payment methods
          ],
        ),
      ),
    );
  }
}
