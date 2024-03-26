import 'package:flutter/material.dart';

@immutable
final class JobModel {
  final String id;
  final String title;
  final String company;
  final String description;
  final String image;
  final String location;
  final String employmentType;
  final String datePosted;
  final String salaryRange;
  // final List<Map<String, dynamic>> jobProviders;

  const JobModel({required this.id, required this.title, required this.company, required this.description, required this.image, required this.location, required this.employmentType, required this.datePosted, required this.salaryRange /*, required this.jobProviders*/});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      location: json['location'] as String,
      employmentType: json['employmentType'] as String,
      datePosted: json['datePosted'] as String,
      salaryRange: json['salaryRange'] as String,
      //   jobProviders: List<Map<String, dynamic>>.from(json['jobProviders'].map((Map<String, dynamic> provider) => <String, dynamic>{'jobProvider': provider['jobProvider'], 'url': provider['url']})),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'company': company,
      'description': description,
      'image': image,
      'location': location,
      'employmentType': employmentType,
      'datePosted': datePosted,
      'salaryRange': salaryRange,
      // 'jobProviders': jobProviders,
    };
  }
}
