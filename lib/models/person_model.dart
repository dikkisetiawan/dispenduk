import 'package:dispenduk/models/kartu_keluarga_model.dart';

//obyek Orang
class PersonModel extends KartuKeluargaModel {
  final String? id;
  final int? nomorIndukKependudukan;
  final String? namaLengkap;
  final DateTime? tanggalLahir;
  final String? tempatLahir;
  final String email;
  final String password;

  PersonModel({
    this.id,
    this.nomorIndukKependudukan,
    super.idKartuKeluarga,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    required this.email,
    required this.password,
  }) : super([]);

  @override
  // TODO: implement props
  List<Object?> get props => [
        nomorIndukKependudukan,
        idKartuKeluarga,
        namaLengkap,
        tempatLahir,
        tanggalLahir,
        email,
        password
      ];
}
