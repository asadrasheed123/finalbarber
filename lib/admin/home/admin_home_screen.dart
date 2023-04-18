
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../screens/widgets/adminsupport.dart';
import 'allshops.dart';
import 'allusers.dart';
import 'booking_screen.dart';
import 'notifications.dart';

class BarberAdminHomeScreen extends StatefulWidget {
  @override
  _BarberAdminHomeScreenState createState() => _BarberAdminHomeScreenState();
}

class _BarberAdminHomeScreenState extends State<BarberAdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Barb App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to BARB',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'What would you like to do today?',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildAdminOptionCard(
                    icon: Icons.message,
                    label: 'Admin Support',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => adminsupport()),
                      );

                    },
                  ),
                  _buildAdminOptionCard(
                    icon: Icons.person,
                    label: 'All Users',
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CustomersPage();
                      }));
                    },
                  ),
                  _buildAdminOptionCard(
                    icon: Icons.book,
                    label: 'See Bookings',
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShowAppointment();
                      }));
                    },
                  ),
                  _buildAdminOptionCard(
                    icon: Icons.door_back_door,
                    label: 'All Shops',
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShopOwnersPage();
                      }));
                    },
                  ),
              InkWell(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessageScreen()),
                  );

                },
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      badges.Badge(
                        badgeContent: Text('0',style: TextStyle(color: Colors.white),),badgeStyle: badges.BadgeStyle(badgeColor: Colors.black54),
                        child: Icon(Icons.notification_important,size: 64,color: Colors.black54,
                      ),),
                      SizedBox(height: 8.0),
                      Text(
                        'notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminOptionCard(
      {required IconData icon, required String label, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64.0,
              color: Colors.black54,
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
