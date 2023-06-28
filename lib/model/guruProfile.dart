class Guru {
  final int userId;
  final String nama;
  final String npp;
  final String email;
  final String password;
  final String jabatan;
  final String? fotoProfil;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int idGuru;

  Guru({
    required this.userId,
    required this.nama,
    required this.npp,
    required this.email,
    required this.password,
    required this.jabatan,
    this.fotoProfil,
    this.createdAt,
    this.updatedAt,
    required this.idGuru,
  });

  factory Guru.fromJson(Map<String, dynamic> json) {
    return Guru(
        userId: json['user_id'],
        nama: json['nama'],
        npp: json['npp'],
        email: json['email'],
        password: json['password'],
        jabatan: json['jabatan'],
        fotoProfil: json['foto_profil'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        idGuru: json['id_guru']);
  }

  Map<String, dynamic> toJson() {
    return {
      // Mapping properti ke dalam bentuk JSON
      'userId': userId,
      'nama': nama,
      'npp': npp,
      'email': email,
      'password': password,
      'jabatan': jabatan,
      'fotoProfil': fotoProfil,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'idGuru': idGuru,
    };
  }
}
