import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Home.dart';

class HouseDetailPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final house = ref.watch(selectedHouseProvider.state).state;
    if (house == null) {
      return Scaffold(
        appBar: AppBar(title: Text('House Details')),
        body: Center(child: Text('No house selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(house.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(house.imageUrl, width: double.infinity, height: 250, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(house.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(house.location, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 24),
                Text('${house.rating}', style: TextStyle(fontSize: 24)),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'This upscale, contemporary hotel is 2 km from Hazrat Shahjalal International Airport and 11 km from Jatiyo Sangsad Bhaban, the Bangladesh Parliament complex.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text('Pricing Plan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PricingButton(label: 'Pay Now', price: '\$77,000'),
                PricingButton(label: 'Monthly', price: '\$450'),
                PricingButton(label: 'Yearly', price: '\$50,000'),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingButton extends StatelessWidget {
  final String label;
  final String price;

  PricingButton({required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(price, style: TextStyle(fontSize: 16, color: Colors.blue)),
      ],
    );
  }
}
