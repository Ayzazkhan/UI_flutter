import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'HouseDetailPage.dart';

// House model class
class House {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;

  House({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });
}

// Riverpod state provider
final selectedHouseProvider = StateProvider<House?>((ref) => null);

class MainPage extends ConsumerWidget {
  final List<House> houses = [
    House(name: 'Marlin Tower', location: 'Tokyo square, Japan', imageUrl: 'assets/Image/img_1.png', rating: 4.5),
    House(name: 'Radison Blue', location: 'Shibuya, Japan', imageUrl: 'assets/Image/img_2.png', rating: 4.2),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Dream Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Image/img_3.jpeg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello John!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Find Your Dream Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search your location',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(label: 'Rent'),
                FilterButton(label: 'Buy'),
                FilterButton(label: 'Sell'),
              ],
            ),
            SizedBox(height: 16),
            Text('Near to you', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  final house = houses[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedHouseProvider.notifier).state = house;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HouseDetailPage()),
                      );
                    },
                    child: HouseCard(house: house),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue, // Set the color for the selected item
        unselectedItemColor: Colors.blue, // Set the color for the unselected items
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;

  FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
      style: ElevatedButton.styleFrom(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final House house;

  HouseCard({required this.house});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.asset(house.imageUrl, width: 150, height: 150, fit: BoxFit.cover),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(house.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(house.location),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Text('${house.rating}', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
