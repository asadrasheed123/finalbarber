// import 'package:barbar_app/screens/profile/payment/payment_method.dart';
import 'package:flutter/material.dart';

import '../payment_method.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  @override
  _PaymentMethodSelectionScreenState createState() =>
      _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState
    extends State<PaymentMethodSelectionScreen> {
  int _selectedMethod = 1; // 0 for PayPal, 1 for Stripe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Select Payment Method'),
      ),
      body: Column(
        children: [
          // SizedBox(height: 16.0),
          // ListTile(
          //   onTap: () {
          //     setState(() {
          //       _selectedMethod = 0;
          //     });
          //   },
          //   leading: Icon(Icons.payment),
          //   title: Text('PayPal'),
          //   trailing: _selectedMethod == 0
          //       ? Icon(Icons.check_circle, color: Colors.green)
          //       : null,
          // ),
          // Divider(),
          ListTile(
            onTap: () {
              setState(() {
                _selectedMethod = 1;
              });
            },
            leading: Icon(Icons.payment),
            title: Text('Stripe'),
            trailing: _selectedMethod == 1
                ? Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PaymentDetailScreen.routeName,
                    arguments: _selectedMethod);
              },
              child: Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
