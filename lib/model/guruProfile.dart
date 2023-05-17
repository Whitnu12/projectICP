class Guru {
  final int userId;
  final String nama;
  final String npp;
  final String email;
  final String password;
  final String jabatan;
  final String? fotoProfil;
  final DateTime createdAt;
  final DateTime updatedAt;

  Guru({
    required this.userId,
    required this.nama,
    required this.npp,
    required this.email,
    required this.password,
    required this.jabatan,
    this.fotoProfil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
      userId: json['user_id'],
      nama: json['nama'],
      npp: json['NPP'],
      email: json['email'],
      password: json['password'],
      jabatan: json['jabatan'],
      fotoProfil: json['foto_profil'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
