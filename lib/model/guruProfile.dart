class User {
  final String name;
  final String nisNip;
  final String token;

  User({
    required this.name,
    required this.nisNip,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      nisNip: json['nis_nip'],
      token: json['token'],
    );
  }
}
