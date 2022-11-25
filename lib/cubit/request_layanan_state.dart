part of 'request_layanan_cubit.dart';

abstract class RequestLayananState extends Equatable {
  const RequestLayananState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestLayananState {}

class FetchRequestLoading extends RequestLayananState {}

class FetchAllRequestSuccess extends RequestLayananState {
  final List<RequestLayananModel> requests;

  FetchAllRequestSuccess(this.requests);

  @override
  List<Object> get props => [requests];
}

class FetchRequestFailed extends RequestLayananState {
  final String error;

  const FetchRequestFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
