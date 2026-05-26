class User {
  final int id;
  final String name;
  final String email;
  final String? googleId;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.googleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      googleId: json['google_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'google_id': googleId,
    };
  }
}
