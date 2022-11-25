import 'package:bloc/bloc.dart';
import 'package:dispenduk/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '/services/auth_service.dart';
import '../services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signInService(email: email, password: password);

      emit(AuthSuccess(user));
      print('cubit mencoba signin : $user');
    } catch (e) {
      emit(AuthFailed(e.toString()));
      print('cubit mencoba signin : $e');
    }
  }

  void signUp({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
      );

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

  void getCurrentUser() async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getCurrentUser();
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getDataCurrentUser() async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getDataCurrentUser();
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateCurrentUser({
    required int nomorIndukKependudukan,
    required int idKartuKeluarga,
    required String namaLengkap,
    required String tempatLahir,
    required DateTime tanggalLahir,
  }) async {
    UserModel user = UserModel(
        nomorIndukKependudukan: nomorIndukKependudukan,
        idKartuKeluarga: idKartuKeluarga,
        namaLengkap: namaLengkap,
        tempatLahir: tempatLahir,
        tanggalLahir: tanggalLahir);

    try {
      emit(AuthLoading());
      await UserService().updateUser(user);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
