class JadwalMengajar {
  final int idMengajar;
  final String namaGuru;
  final String namaKelas;
  final String namaMapel;
  final String jamMulai;
  final String jamSelesai;
  final String hari;

  JadwalMengajar({
    required this.idMengajar,
    required this.namaGuru,
    required this.namaKelas,
    required this.namaMapel,
    required this.jamMulai,
    required this.jamSelesai,
    required this.hari,
  });

  factory JadwalMengajar.fromJson(Map<String, dynamic> json) {
    return JadwalMengajar(
      idMengajar: json['id_mengajar'],
      namaGuru: json['nama_guru'],
      namaKelas: json['nama_kelas'],
      namaMapel: json['nama_mapel'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      hari: json['hari'],
    );
  }
}