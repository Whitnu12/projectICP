class CapaianJam {
  final int idCapaian;
  final int idGuru;
  final int kodeMapel;
  // final String namaGuru;
  final String namaMapel;
  final int targetCapaian;
  final int jamTercapai;

  CapaianJam({
    required this.idCapaian,
    required this.idGuru,
    required this.kodeMapel,
    // required this.namaGuru,
    required this.namaMapel,
    required this.targetCapaian,
    required this.jamTercapai,
  });

  factory CapaianJam.fromJson(Map<String, dynamic> json) {
    return CapaianJam(
        idCapaian: json['id_capaian'],
        idGuru: json['id_guru'],
        kodeMapel: json['kode_mapel'],
        // namaGuru: json['nama_guru'],
        namaMapel: json['mapel']['nama_mapel'],
        targetCapaian: json['capaian_jam'],
        jamTercapai: json['jam_tercapai']);
  }
}
