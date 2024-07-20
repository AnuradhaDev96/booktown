/// Common state to use in data processing (CRUD) actions where specific
/// scenario does not exit. Can be used in any cubit
class DataPayloadState {}

/// Idle state
class InitialState extends DataPayloadState {}

/// Data is processing
class RequestingState extends DataPayloadState {}

/// Action is success
class SuccessState extends DataPayloadState {}

/// Action failed
class ErrorState extends DataPayloadState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
