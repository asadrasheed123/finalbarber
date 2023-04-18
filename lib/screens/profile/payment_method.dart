import 'package:flutter/material.dart';

class PaymentDetailScreen extends StatefulWidget {
  static const routeName = '/Payment';
  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _cardNumber;
  String? _expMonth;
  String? _expYear;
  String? _cvc;
  double? _serviceCharge = 4.99;
  double? _tip = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment Details'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your card information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Card Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a card number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _cardNumber = value;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Expiration Month'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an expiration month';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expMonth = value;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Expiration Year'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an expiration year';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _expYear = value;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'CVC'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a CVC';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cvc = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Service Charge: \$${_serviceCharge!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tip (Optional)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _tip = double.parse(value);
                    }
                  },
                ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    child: Text('Pay Now'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // TODO: Process payment and navigate to payment confirmation screen
                      }
                    },
                  ),
                ),
                Text(
                  'Tip Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Tip Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a tip amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  child: Text('Submit Payment'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Process payment
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
