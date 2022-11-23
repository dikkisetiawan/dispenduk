import 'package:firebase_auth/firebase_auth.dart';
import '/models/person_model.dart';
import '/services/user_services.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

//login
  Future<PersonModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      PersonModel user =
          await UserService().getUserById(userCredential.user!.uid);

      return user;
    } catch (e) {
      print('Mencoba signin $e');
      rethrow;
    }
  }

//register
  Future<PersonModel> signUp({
    required String namaLengkap,
    required String email,
    required String password,
    required int nomorIndukKependudukan,
    required int idKartuKeluarga,
    required String tempatLahir,
    required DateTime tanggalLahir,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      PersonModel user = PersonModel(
          id: userCredential.user!.uid,
          namaLengkap: namaLengkap,
          email: email,
          password: password,
          idKartuKeluarga: idKartuKeluarga,
          nomorIndukKependudukan: nomorIndukKependudukan,
          tanggalLahir: tanggalLahir,
          tempatLahir: tempatLahir);

      await UserService().setUser(user);

      return user;
    } catch (e) {
      print('Mencoba signUp $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Mencoba logout $e');
      rethrow;
    }
  }
}
