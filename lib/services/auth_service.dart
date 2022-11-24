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
      print('services Mencoba signin $e');
      throw e;
    }
  }

//register
  Future<PersonModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      PersonModel user = PersonModel(
        id: userCredential.user!.uid,
        email: email,
        password: password,
        tanggalLahir: null,
      );

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
