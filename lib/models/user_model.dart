import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { owner, manager, employee }

class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] as String,
      email: data['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.name == data['role'],
        orElse: () => UserRole.employee,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
