import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../common_textfield/common_textfield.dart';


class Appoitment extends StatefulWidget {
  const Appoitment({Key? key}) : super(key: key);

  @override
  State<Appoitment> createState() => _AppoitmentState();
}

class _AppoitmentState extends State<Appoitment> {
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
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialogForPriceLevel();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: CommonTextFieldWithTitle(
                    'price',
                    'Select',
                    price,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    },
                    enabled: false,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialogForShops();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: CommonTextFieldWithTitle(
                    'select shops',
                    'Select',
                    shops,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    },
                    enabled: false,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialogForNpkContents();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: CommonTextFieldWithTitle(
                    'Services',
                    'Select',
                    services,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    },
                    enabled: false,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                  ),
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
                isLoading ? Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Checking....", style: TextStyle(fontSize: 18),),
                    SizedBox(width: 5,),
                    CircularProgressIndicator(

                      color: Colors.red,
                    )
                  ],)) : buttonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
          }
        },
        child: const Text(
          'Check',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  showDialogForPriceLevel() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Ph Level'),
            content: Container(
              height: 160,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                price1[index],
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      price.text = price1[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: price1.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }



  showDialogForNpkContents() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Services'),
            content: Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                services1[index],
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      services.text = services1[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: services1.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }


  showDialogForShops() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: titleForDialog(context, 'Select Salinity Soil'),
            content: Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                shopps[index],
                                maxLines: 2,
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      shops.text = shopps[index];
                      setState(() {});
                    },
                  );
                },
                itemCount: shopps.length,
                shrinkWrap: true,
              ),
            ),
          );
        });
  }




  Widget titleForDialog(BuildContext context, String title) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Center(
        child: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 17, height: 1.55), textAlign: TextAlign.center),
      ),
    );
  }


}
