import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common_textfield/common_textfield.dart';



class Appoitment extends StatefulWidget {
  const Appoitment({Key? key}) : super(key: key);

  @override
  State<Appoitment> createState() => _AppoitmentState();
}

class _AppoitmentState extends State<Appoitment> {
  String? selectedPrice;
  String? selectedshop;
  String? selectedservice;
  TextEditingController price = TextEditingController();
  TextEditingController shops = TextEditingController();
  TextEditingController services = TextEditingController();

  FocusNode searchFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<String> price1 = ["10\$", "15\$", "20\$","30\$" ];
  List<String> services1 = ["Hair cut", "Bread Trim", "Hair dye", "Styling", "Grooming","Line up","Tatto"];
  List<String> shopps = ["shop1", "shop2", "shop3", "shop4"];
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<String> _staff = ['Stylist', 'Tatoo Artist', 'Barbar'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  Future<void> saveToFirebase(String price, String service, DateTime dateTime) async {
    try {
      await FirebaseFirestore.instance.collection('appointments').add({
        'price': price,
        'service': service,
        'dateTime': dateTime,
      });
    } catch (e) {
      print('Error saving to Firebase: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Services"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Container(
                      height: 100,
                      width: 120,
                      child: Image.asset("assets/images/logo23.png")),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedPrice,
                  items: price1.map((String price) {
                    return DropdownMenuItem<String>(
                      value: price,
                      child: Text(price),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPrice = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'shop',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedshop,
                  items: shopps.map((String price) {
                    return DropdownMenuItem<String>(
                      value: price,
                      child: Text(price),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedshop = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Services',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedservice,
                  items: services1.map((String price) {
                    return DropdownMenuItem<String>(
                      value: price,
                      child: Text(price),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedservice = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(

                      children: [
                        Text("Select Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(_selectedDate),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text("Select Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        TextButton(
                          onPressed: () => _selectTime(context),
                          child: Text(
                            _selectedTime.format(context),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final snackBar = SnackBar(
                        content: Text('“you have not subscribe to be a premium member, service fee is waived for premium members”',style: TextStyle(color: Colors.white)),
                        duration: Duration(seconds: 5),
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,

                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      saveToFirebase(selectedPrice!, selectedservice!, DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute)).then((_) {

                          makepayment("30", "USD");

                      });


                    }
                  },
                  child: isLoading ? const CircularProgressIndicator() : const Text("Save"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Map<String,dynamic>? paymentIntentData;
  Future<void> makepayment(String amount,String currency)async{
    try{
      paymentIntentData=await createPaymentIntent(amount,currency);
      if(paymentIntentData!=null){
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(customFlow:true,

              // applePay: true,
                googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
                style: ThemeMode.dark,
                merchantDisplayName: "Prospects",
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralkey']

            ));
        displayPaymentSheet();
      }
    }catch(e,s){
      print("EXCEPTION ===$e$s");

    }

  }

  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String,dynamic> body={
        'amount':calculateAmount(amount),
        'currency':currency,

        'payment_method_types[]':'card'
      };
      var response=await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,headers: {
            'Authorization':"Bearer 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",
            'Content-Type':'application/x-www-form-urlencoded'
          }
      );
      return jsonDecode(response.body);
    }catch(err){
      print("err charging user $err");
    }
  }


  void displayPaymentSheet()async {
    try{
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar("Payment info", "pay successful");
    }on Exception catch(e){
      if(e is StripeException){
        print("error from stripe $e");
      }else{
        print("Unforeseen error $e");
      }
    }catch(e){
      print("exception===$e");
    }
  }

  calculateAmount(String amount) {
    final originalAmount = double.parse(amount);
    final serviceCharge = 4.99;
    final totalAmount = originalAmount + serviceCharge;
    final centsAmount = (totalAmount * 100).toInt();
    return centsAmount.toString();
  }




}


