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
    on<DetailTopicManagerEventClickEvent>(_detailTopicManagerEventClickEvent);
    on<DeleteTopicManagerEvent>(_deleteTopicManagerEvent);
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

  FutureOr<void> _detailTopicManagerEventClickEvent(DetailTopicManagerEventClickEvent event, Emitter<TopicManagerState> emit) {
    emit(DetailTopicManagerEventClickState(topic: event.topic));
  }

  FutureOr<void> _deleteTopicManagerEvent(DeleteTopicManagerEvent event, Emitter<TopicManagerState> emit) {
    emit(TopicManagerLoadingState());
    event.topicList!.remove(event.topic);
    emit(TopicManagerSuccessState(topicList: event.topicList ?? []));
  }
}
