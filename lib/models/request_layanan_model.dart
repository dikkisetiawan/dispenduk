import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Status {
  Pending([Colors.grey, Icons.browse_gallery_outlined]),
  Verifikasi([Colors.blue, Icons.saved_search_outlined]),
  Revisi([Colors.orange, Icons.warning_amber_outlined]),
  Ditolak([Colors.red, Icons.warning_amber_outlined]),
  Validasi([Colors.green, Icons.done_outline_outlined]);

  const Status(this.statusValue);
  final List<dynamic> statusValue;
}

class RequestLayananModel extends Equatable {
  final String? idPermohonan;
  final DateTime? tanggalPermohonan;
  final String layanan;
  final Status status;
  final String? keterangan;

  RequestLayananModel({
    this.idPermohonan,
    this.tanggalPermohonan,
    required this.layanan,
    required this.status,
    this.keterangan,
  });

  Map<String, dynamic> toJson() => {
        'status': status.name.toString(),
        'tanggalPermohonan': tanggalPermohonan,
        'layanan': layanan,
        'keterangan': keterangan,
      };

  factory RequestLayananModel.fromJson(String id, Map<String, dynamic> json) =>
      RequestLayananModel(
        idPermohonan: id,
        status: Status.values.byName(json['status']),
        tanggalPermohonan: DateTime.tryParse(json['tanggalPermohonan']),
        layanan: json['layanan'],
        keterangan: json['keterangan'],
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [idPermohonan, status, tanggalPermohonan, layanan, keterangan];
}
