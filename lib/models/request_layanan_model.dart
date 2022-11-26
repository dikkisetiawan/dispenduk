import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum Status {
  pending([Colors.grey, Icons.browse_gallery_outlined]),
  verifikasi([Colors.blue, Icons.saved_search_outlined]),
  revisi([Colors.orange, Icons.warning_amber_outlined]),
  ditolak([Colors.red, Icons.warning_amber_outlined]),
  validasi([Colors.green, Icons.done_outline_outlined]);

  const Status(this.statusValue);
  final List<dynamic> statusValue;
}

class RequestLayananModel extends Equatable {
  final String? idPermohonan;
  final DateTime? tanggalPermohonan;
  final String layanan;
  final Status status;
  final String? keterangan;

  const RequestLayananModel({
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
  List<Object?> get props =>
      [idPermohonan, status, tanggalPermohonan, layanan, keterangan];
}
