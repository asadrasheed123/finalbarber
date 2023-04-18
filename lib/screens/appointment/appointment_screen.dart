import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedService;
  String? _selectedStaff;

  final List<String> _services = [
    'Haircut',
    'Beard trim',
    'Hair dye',
    'Styling',
    'Grooming',
    'Line up',
    'Tattoo'
  ];
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
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                const Text(
                  'Select a service:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedService,
                      hint: const Text('Select a service'),
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value!;
                        });
                      },
                      items: _services.map((String service) {
                        return DropdownMenuItem<String>(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: _selectedStaff,
                      hint: const Text('Select Staff'),
                      onChanged: (value) {
                        setState(() {
                          _selectedStaff = value!;
                        });
                      },
                      items: _staff.map((String service) {
                        return DropdownMenuItem<String>(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select a date:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectTime(context),
                        child: Text(
                          _selectedTime.format(context),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Add appointment to calendar
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Appointment created successfully'),
                      ));
                    },
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.red.shade900,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: const Center(
                                child: Text('Create appointment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )))),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return AppointmentCard(
                                appointmentType: 'Styling',
                                barberShopName: 'The Hair Salon',
                                appointmentDateTime:
                                    'Wednesday, 20th April 2023 at 10:00 AM',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ));
  }
}

class AppointmentCard extends StatelessWidget {
  final String appointmentType;
  final String barberShopName;
  final String appointmentDateTime;

  AppointmentCard({
    required this.appointmentType,
    required this.barberShopName,
    required this.appointmentDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointmentType,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AppointmentCard(
                            appointmentType: appointmentType,
                            barberShopName: barberShopName,
                            appointmentDateTime: appointmentDateTime);
                      }));
                    },
                    child: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              barberShopName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              appointmentDateTime,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
