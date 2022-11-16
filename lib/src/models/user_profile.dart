import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie.dart

class UserProfile {
  String displayName;
  bool active;
  DateTime? lastActive;
  String id;

  UserProfile({
    required this.displayName,
    required this.id,
    this.active = true,
    this.lastActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'display_name': displayName,
      'active': active,
      'last_active': lastActive,
      'id': id,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      displayName: map['display_name'] ?? 'Unnamed',
      active: map['active'] ?? false,
      lastActive: map['last_active'] ?? DateTime.now(),
      id: map['id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  static UserProfile fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    return UserProfile(
      displayName: map['display_name'] ?? 'Unnamed',
      active: map['active'] ?? false,
      lastActive: map['last_active'] ?? DateTime.now(),
      id: snapshot.id,
    );
  }
}
