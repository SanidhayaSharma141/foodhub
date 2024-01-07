import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Restaurants {
  int id;
  String name;
  String tags;
  double discount;
  String imageUrl;
  double distance;

  Restaurants(
      {required this.discount,
      required this.distance,
      required this.imageUrl,
      required this.id,
      required this.name,
      required this.tags});
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final double discount;
  final String imageUrl;

  RestaurantCard({
    required this.name,
    required this.discount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      '${discount.toStringAsFixed(0)}% off',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
