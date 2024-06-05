import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';

class Reservations extends StatefulWidget {
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<Map<String, dynamic>> reservationItems = [];

  @override
  void initState() {
    super.initState();
    _fetchReservations();
  }

  Future<void> _fetchReservations() async {
    List<Map<String, dynamic>> fetchedReservations =
        await DatabaseHelper().getAllReservations();
    setState(() {
      reservationItems = fetchedReservations;
    });
  }

  void _deleteReservation(int id) async {
    await DatabaseHelper().deleteReservation(id);
    _fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Reservations'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 255, 255), // Light purple tone 1
              Color.fromARGB(255, 223, 204, 231), // Light purple tone 2
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: reservationItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var reservation = reservationItems[index];
                      return ReservationItemWidget(
                        reservationItem: reservation,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmation"),
                                content: Text(
                                    "Are you sure you want to delete this reservation?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _deleteReservation(reservation['id']);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReservationItemWidget extends StatelessWidget {
  final Map<String, dynamic> reservationItem;
  final VoidCallback onDelete;

  const ReservationItemWidget({
    Key? key,
    required this.reservationItem,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        title: Text('Car Name: ${reservationItem['carName']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${reservationItem['name']}'),
            Text('Phone Number: ${reservationItem['phoneNumber']}'),
            Text('Pickup Date: ${reservationItem['pickupDate']}'),
            Text('Return Date: ${reservationItem['returnDate']}'),
            Text('Delivery Address: ${reservationItem['deliveryAddress']}'),
            InkWell(
              onTap: onDelete,
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
