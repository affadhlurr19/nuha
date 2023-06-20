import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consultant {
  String consultantId;
  String name;
  String category;
  String description;
  String imageUrl;
  String lastEducation;
  String location;
  String price;
  String sertificationId;
  bool isAvailable;

  Consultant({
    required this.consultantId,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.lastEducation,
    required this.location,
    required this.price,
    required this.sertificationId,
    required this.isAvailable,
  });

  factory Consultant.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Consultant(
      consultantId: snapshot.id,
      name: data['name'],
      category: data['category'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      lastEducation: data['lastEducation'],
      location: data['location'],
      price: data['price'].toString(),
      sertificationId: data['sertificationId'],
      isAvailable: data['isAvailable'],
    );
  }
}
