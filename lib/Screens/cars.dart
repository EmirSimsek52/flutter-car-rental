import 'package:flutter/material.dart';

class Cars extends StatelessWidget {
  final List<CarItem> carItems = [
    CarItem(
      imageUrl:
          'https://rk.mb-qr.com/media/thumbnails/cards/205040_000_200221_101604_SFL2052_8.png.860x860_q95.png',
      carName: 'Mercedes-Benz C-Class',
      price: '\$50/Day',
      km: '250km/Daily',
    ),
    CarItem(
      imageUrl:
          'https://www.motortrend.com/uploads/sites/10/2020/03/2020-volvo-xc90-momentum-4wd-suv-angular-front.png',
      carName: 'Volvo XC-90',
      price: '\$45/Day',
      km: '300km/Daily',
    ),
    CarItem(
      imageUrl:
          'https://images.dealer.com/ddc/vehicles/2024/Audi/A4/Sedan/perspective/front-left/2024_24.png',
      carName: 'Audi A4',
      price: '\$48/Day',
      km: '300km/Daily',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                Text(
                  'Cars',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9C27B0),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: carItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CarListItem(carItem: carItems[index]);
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

  const CarListItem({Key? key, required this.carItem}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
