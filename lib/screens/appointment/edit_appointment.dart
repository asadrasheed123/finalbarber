import 'package:flutter/material.dart';

class AppointmentCard extends StatefulWidget {
  final String appointmentType;
  final String barberShopName;
  final String appointmentDateTime;

  AppointmentCard({
    required this.appointmentType,
    required this.barberShopName,
    required this.appointmentDateTime,
  });

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isEditing = false;
  TextEditingController _appointmentTypeController = TextEditingController();
  TextEditingController _barberShopNameController = TextEditingController();
  TextEditingController _appointmentDateTimeController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _appointmentTypeController.text = widget.appointmentType;
    _barberShopNameController.text = widget.barberShopName;
    _appointmentDateTimeController.text = widget.appointmentDateTime;
  }

  @override
  void dispose() {
    _appointmentTypeController.dispose();
    _barberShopNameController.dispose();
    _appointmentDateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Edit Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _isEditing
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Edit Appointment',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _appointmentTypeController,
                            decoration: const InputDecoration(
                              hintText: 'Appointment Type',
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _barberShopNameController,
                            decoration: const InputDecoration(
                              hintText: 'Barber Shop Name',
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _appointmentDateTimeController,
                            decoration: const InputDecoration(
                              hintText: 'Appointment Date and Time',
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.appointmentType,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.barberShopName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.appointmentDateTime,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
