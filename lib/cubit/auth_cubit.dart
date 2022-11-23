import 'package:bloc/bloc.dart';
import 'package:dispenduk/models/person_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/models/person_model.dart';
import '/services/auth_service.dart';
import '/services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      PersonModel user =
          await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String namaLengkap,
    required String email,
    required String password,
    required int nomorIndukKependudukan,
    required int idKartuKeluarga,
    required String tempatLahir,
    required DateTime tanggalLahir,
  }) async {
    try {
      emit(AuthLoading());
      PersonModel user = await AuthService().signUp(
          namaLengkap: namaLengkap,
          email: email,
          password: password,
          idKartuKeluarga: idKartuKeluarga,
          nomorIndukKependudukan: nomorIndukKependudukan,
          tanggalLahir: tanggalLahir,
          tempatLahir: tempatLahir);
      print('cubit mencoba signup : $user');
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
      print('cubit mencoba signup $e');
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      PersonModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
