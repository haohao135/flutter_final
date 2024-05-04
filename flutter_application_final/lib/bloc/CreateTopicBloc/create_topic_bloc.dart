import 'dart:async';

import 'package:bloc/bloc.dart';

part 'create_topic_event.dart';
part 'create_topic_state.dart';
class CreateTopicBloc extends Bloc<CreateTopicEvent, CreateTopicState> {
  CreateTopicBloc() : super(CreateTopicInitial()) {
    on<CreateTopicEventInitial>(_inittialEvent);
    on<ClickFloattingButtonEvent>(_clickFloattingButtonEvent);
    on<ClickCompleteButtonEvent>(_clickCompleteButtonEvent);
    on<ClickScanDocumentButtonEvent>(_clickScanDocumentButtonEvent);
    on<Error>(_error);
  }

  FutureOr<void> _inittialEvent(
      CreateTopicEvent event, Emitter<CreateTopicState> emit) {
      emit(const CreateTopicIsSuccess(count: 1));
  }

  FutureOr<void> _clickFloattingButtonEvent(
      ClickFloattingButtonEvent event, Emitter<CreateTopicState> emit) {
     emit(CreateTopicIsSuccess(count: event.count+1));
  }

  FutureOr<void> _clickCompleteButtonEvent(
      ClickCompleteButtonEvent event, Emitter<CreateTopicState> emit) {
  }

  FutureOr<void> _clickScanDocumentButtonEvent(
      ClickScanDocumentButtonEvent event, Emitter<CreateTopicState> emit) {
     emit(CreateTopicScanDocumentClick());
  }

  FutureOr<void> _error(Error event, Emitter<CreateTopicState> emit) {
    emit(CreateTopicError());
  }
}
