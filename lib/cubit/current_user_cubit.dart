import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<String> {
  CurrentUserCubit() : super('');

  String uid = '';

  void setUid(String value) {
    uid = value;
    emit(uid);
  }

  String getUid() {
    return uid;
  }
}
