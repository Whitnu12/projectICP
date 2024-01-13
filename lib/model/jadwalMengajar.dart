class JadwalMengajar {
  final int idMengajar;
  final String namaGuru;
  final String namaKelas;
  final String namaMapel;
  final int jamBelajar;
  final String jamMulai;
  final String jamSelesai;
  final String hari;

  JadwalMengajar({
    required this.idMengajar,
    required this.namaGuru,
    required this.namaKelas,
    required this.namaMapel,
    required this.jamMulai,
    required this.jamBelajar,
    required this.jamSelesai,
    required this.hari,
  });

  factory JadwalMengajar.fromJson(Map<String, dynamic> json) {
    return JadwalMengajar(
      idMengajar: json['id_mengajar'],
      namaGuru: json['guru']['nama'],
      namaKelas: json['kelas']['kode_kelas'],
      namaMapel: json['mapel']['nama_mapel'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      jamBelajar: json['jam_belajar'],
      hari: json['hari'],
    );
  }
}
