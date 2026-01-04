import 'package:flutter/material.dart';

class Property {
  final String id;
  final String title;
  final String type;
  final String address;
  final double rating;
  final String price;
  final String imageUrl;
  final String tag; // "Rent" or "Sale"

  Property({
    required this.id,
    required this.title,
    required this.type,
    required this.address,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.tag,
  });
}

class BannerItem {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description1;
  final String description2;

  BannerItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description1,
    required this.description2,
  });
}

class PropertyCategory {
  final String id;
  final String name;
  final IconData icon;

  PropertyCategory({
    required this.id,
    required this.name,
    required this.icon,
  });
}

