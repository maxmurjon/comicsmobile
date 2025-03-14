class User {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;

  User({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      imageUrl: json['image_url'],
    );
  }
}
