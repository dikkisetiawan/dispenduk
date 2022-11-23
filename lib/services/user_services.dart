import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/person_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(PersonModel user) async {
    try {
      _userReference.doc(user.id).set({
        'name': user.namaLengkap,
        'email': user.email,
        'password': user.password,
        'nik': user.nomorIndukKependudukan,
        'nokk': user.idKartuKeluarga,
        'tempatLahir': user.tempatLahir,
        'tanggalLahir': user.tanggalLahir,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<PersonModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return PersonModel(
        id: id,
        namaLengkap: snapshot['name'],
        email: snapshot['email'],
        password: snapshot['password'],
        idKartuKeluarga: snapshot['nokk'],
        nomorIndukKependudukan: snapshot['nik'],
        tanggalLahir: snapshot['tempatLahir'],
        tempatLahir: snapshot['tanggalLahir'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
