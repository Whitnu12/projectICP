class Laporan {
  final String judulLaporan;
  final String deskripsiLaporan;
  final String tanggal;
  final String jenisLaporan;
  final String pengirim;
  final String gambar;

  Laporan({
    required this.judulLaporan,
    required this.deskripsiLaporan,
    required this.tanggal,
    required this.jenisLaporan,
    required this.pengirim,
    required this.gambar,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      judulLaporan: json['judul_laporan'],
      deskripsiLaporan: json['deskripsi_laporan'],
      tanggal: json['tanggal'],
      jenisLaporan: json['id_jenis'],
      pengirim: json['id_guru'],
      gambar: json['gambar'],
    );
  }
}
