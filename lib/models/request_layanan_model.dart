enum Status {
  pending,
  verifikasi,
  revisi,
  ditolak;
}

class RequestLayananModel {
  final int idPermohonan;
  final DateTime tanggalPermohonan;
  final String layanan;
  final Status status;

  RequestLayananModel(
    this.idPermohonan,
    this.tanggalPermohonan, {
    required this.layanan,
    required this.status,
  });
}
