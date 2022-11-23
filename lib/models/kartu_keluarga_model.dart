//obyek keluarga
import 'package:equatable/equatable.dart';

import '/models/person_model.dart';

class KartuKeluargaModel extends Equatable {
  final int idKartuKeluarga;
  final List<PersonModel> anggotaKeluarga;

  KartuKeluargaModel(this.anggotaKeluarga, {required this.idKartuKeluarga});

  @override
  // TODO: implement props
  List<Object?> get props => [idKartuKeluarga, anggotaKeluarga];
}
