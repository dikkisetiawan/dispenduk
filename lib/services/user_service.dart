import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  User? credentialUser = FirebaseAuth.instance.currentUser;

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'namaLengkap': user.namaLengkap,
        'kk': user.idKartuKeluarga,
        'nik': user.nomorIndukKependudukan,
        'tempatLahir': user.tempatLahir,
        'tanggalLahir': user.tanggalLahir,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      _userReference.doc(credentialUser!.uid).update({
        'namaLengkap': user.namaLengkap,
        'kk': user.idKartuKeluarga,
        'nik': user.nomorIndukKependudukan,
        'tempatLahir': user.tempatLahir,
        'tanggalLahir': user.tanggalLahir.toString(),
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      DocumentSnapshot snapshot =
          await _userReference.doc(credentialUser!.uid).get();
      return UserModel(
        email: snapshot['email'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getDataCurrentUser() async {
    try {
      DocumentSnapshot snapshot =
          await _userReference.doc(credentialUser!.uid).get();
      return UserModel(
        id: snapshot.id,
        email: snapshot['email'],
        nomorIndukKependudukan: snapshot['nik'],
        idKartuKeluarga: snapshot['kk'],
        namaLengkap: snapshot['namaLengkap'],
        tempatLahir: snapshot['tempatLahir'],
        tanggalLahir: DateTime.tryParse(snapshot['tanggalLahir']),
      );
    } catch (e) {
      rethrow;
    }
  }
}
