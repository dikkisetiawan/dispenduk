part of 'request_layanan_cubit.dart';

abstract class RequestLayananState extends Equatable {
  const RequestLayananState();

  @override
  List<Object> get props => [];
}

class RequestInitial extends RequestLayananState {}

class FetchRequestLoading extends RequestLayananState {}

class CreateRequestLayananLoading extends RequestLayananState {}

class CreateRequestLayananSuccess extends RequestLayananState {}

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
  List<Object> get props => [error];
}

class CreateRequestLayananFailed extends RequestLayananState {
  final String error;

  const CreateRequestLayananFailed(this.error);

  @override
  List<Object> get props => [error];
}
