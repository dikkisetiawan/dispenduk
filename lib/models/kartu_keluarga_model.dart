//obyek keluarga
import 'package:equatable/equatable.dart';

import 'user_model.dart';

class KartuKeluargaModel extends Equatable {
  final int? idKartuKeluarga;
  final List<UserModel> anggotaKeluarga;

  KartuKeluargaModel(this.anggotaKeluarga, {this.idKartuKeluarga});

  @override
  // TODO: implement props
  List<Object?> get props => [idKartuKeluarga, anggotaKeluarga];
}
