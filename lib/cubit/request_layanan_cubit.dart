import 'package:dispenduk/models/request_layanan_model.dart';
import 'package:dispenduk/services/request_layanan_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_layanan_state.dart';

class RequestLayananCubit extends Cubit<RequestLayananState> {
  RequestLayananCubit() : super(RequestInitial());

  void createRequestLayanan(RequestLayananModel request) async {
    try {
      emit(CreateRequestLayananLoading());
      await RequestLayananService().createRequestService(request);
      emit(CreateRequestLayananSuccess());
    } catch (e) {
      emit(CreateRequestLayananFailed(e.toString()));
    }
  }

  void fetchRequestsByCurrentUser() async {
    try {
      emit(FetchRequestLoading());

      List<RequestLayananModel> requests =
          await RequestLayananService().fetchRequestsByCurrentUser();

      emit(FetchAllRequestSuccess(requests));
    } catch (e) {
      emit(FetchRequestFailed(e.toString()));
    }
  }
}
