import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';

class AdminCars extends StatefulWidget {
  @override
  _AdminCarsState createState() => _AdminCarsState();
}

class _AdminCarsState extends State<AdminCars> {
  List<CarItem> carItems = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    List<Map<String, dynamic>> carList = await DatabaseHelper().getAllCars();
    setState(() {
      carItems = carList.map((car) {
        return CarItem(
          imageUrl: car['image_url'],
          carName: car['name'],
          price: car['daily_price'],
          km: car['daily_km'],
        );
      }).toList();
    });
  }

  Future<void> _deleteCar(int index) async {
    String carName = carItems[index].carName;
    await DatabaseHelper().deleteCar(carName);
    _loadCars(); // Refresh the car list
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Cars'),
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
              Color.fromARGB(255, 255, 255, 255), // Açık mor tonu 1
              Color.fromARGB(255, 223, 204, 231), // Açık mor tonu 2
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
                  child: carItems.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: carItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CarListItem(
                              carItem: carItems[index],
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Confirmation"),
                                      content: Text(
                                          "Are you sure you want to delete this car?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            _deleteCar(index);
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

class CarItem {
  final String imageUrl;
  final String carName;
  final String price;
  final String km;

  CarItem({
    required this.imageUrl,
    required this.carName,
    required this.price,
    required this.km,
  });
}

class CarListItem extends StatelessWidget {
  final CarItem carItem;
  final VoidCallback onDelete;

  const CarListItem({
    Key? key,
    required this.carItem,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: Image.network(
          carItem.imageUrl,
          width: 120,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(carItem.carName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: ${carItem.price}'),
            Text('Kilometers: ${carItem.km}'),
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
