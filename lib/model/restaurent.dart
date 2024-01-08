import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Restaurants {
  String name;
  String tags;
  double discount;
  String imageUrl;
  double distance;
  double rating;
  Restaurants(
      {required this.discount,
      required this.distance,
      required this.imageUrl,
      required this.rating,
      required this.name,
      required this.tags});
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final double discount;
  final String imageUrl;
  final double rating;

  RestaurantCard(
      {required this.name,
      required this.discount,
      required this.imageUrl,
      required this.rating});

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
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          rating.toString(),
                        ),
                        Icon(Icons.star),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      '${discount.toStringAsFixed(0)}% FLAT OFF',
                      style: TextStyle(
                        color: Colors.red,
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
