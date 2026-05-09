/// Model untuk pengguna/User
class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      profilePicture: json['profilePicture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // CopyWith untuk update data
  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profilePicture,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
