import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Image.network(
            'https://a3.espncdn.com/combiner/i?img=%2Fphoto%2F2025%2F0611%2Fr1505274_1000x400_5%2D2.jpg&w=628&h=251&scale=crop&cquality=80&location=center&format=jpg',
          ),
          SizedBox(height: 8),
          Text(
            'James vs. Messi, el áspero cruce entre los cracks de Colombia y Argentina',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            '28 may 2025',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
