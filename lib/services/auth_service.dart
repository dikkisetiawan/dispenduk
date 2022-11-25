import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'user_services.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

//login
  Future<UserModel> signInService({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user = await UserService().getDataCurrentUser();

      return user;
    } catch (e) {
      print('services Mencoba signin $e');
      throw e;
    }
  }

//register
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        password: password,
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
