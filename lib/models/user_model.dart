
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String gender;
  final String? phoneNumber;
  final String? profileImage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    this.phoneNumber,
    this.profileImage,
  });

  // fromJson factory constructor
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'gender':gender,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? gender,
    String? phoneNumber,
    String? profileImage,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      gender:gender??this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
    );
  }



}