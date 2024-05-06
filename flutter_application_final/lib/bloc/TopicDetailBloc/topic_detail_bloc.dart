import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_final/model/topic.dart';


part 'topic_detail_event.dart';
part 'topic_detail_state.dart';

class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  TopicDetailBloc() : super(TopicDetailInitialState()) {
    on<TopicDetailInitialEvent>(_topicDetailInitialEvent);
    on<TopicDetailFlashCardClicklEvent>(_topicDetailFlashCardClicklEvent);
  }

  FutureOr<void> _topicDetailInitialEvent(TopicDetailInitialEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailSuccesslState(topic: event.topic));
  }

  FutureOr<void> _topicDetailFlashCardClicklEvent(TopicDetailFlashCardClicklEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailFlashCardClicklState(topic: event.topic, total: event.total));
  }
}
