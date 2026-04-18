import 'package:flutter/material.dart';

class Property {
  final String id;
  final String title;
  final String type;
  final String address;
  final double rating;
  final String price;
  final String imageUrl;
  final String tag; // Rent / Sale
  final int bedrooms;
  final int bathrooms;
  final int areaSqft;
  final String ownerName;
  final String ownerLogo;
  final String? growthRate; // e.g. "20% growing"

  Property({
    required this.id,
    required this.title,
    required this.type,
    required this.address,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.tag,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSqft,
    required this.ownerName,
    required this.ownerLogo,
    this.growthRate,
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
