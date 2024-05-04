import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_final/model/topic.dart';

part 'topic_manager_event.dart';
part 'topic_manager_state.dart';

class TopicManagerBloc extends Bloc<TopicManagerEvent, TopicManagerState> {
  TopicManagerBloc() : super(TopicManagerInitialState()) {
    on<InitialTopicManagerEvent>(_initialTopicManagerEvent);
    on<CreateTopicManagerEvent>(_createTopicManagerEvent);
    on<LoadingTopicManagerEvent>(_loadingTopicManagerEvent);
  }

  FutureOr<void> _initialTopicManagerEvent(InitialTopicManagerEvent event, Emitter<TopicManagerState> emit) {
    if(event.hasTopic){
      emit(TopicManagerSuccessState(topicList: event.topicList ?? []));
    } else{
      emit(TopicManagerNoTopicState());
    }
  }

  FutureOr<void> _createTopicManagerEvent(CreateTopicManagerEvent event, Emitter<TopicManagerState> emit) {
  }

  FutureOr<void> _loadingTopicManagerEvent(LoadingTopicManagerEvent event, Emitter<TopicManagerState> emit) {
    emit(TopicManagerLoadingState());
  }
}
