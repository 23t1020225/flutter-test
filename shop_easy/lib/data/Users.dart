class Users {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String birthDate;
  final String email;
  final String image;

  Users({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.birthDate,
    required this.email,
    required this.image,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      age: (json['age'] as num).toInt(),
      gender: json['gender'],
      birthDate: json['birthDate'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }
}
