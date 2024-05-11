import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/word.dart';


part 'topic_detail_event.dart';
part 'topic_detail_state.dart';

class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  TopicDetailBloc() : super(TopicDetailInitialState()) {
    on<TopicDetailInitialEvent>(_topicDetailInitialEvent);
    on<TopicDetailFlashCardClicklEvent>(_topicDetailFlashCardClicklEvent);
    on<TopicDetailQuizzClicklEvent>(_topicDetailQuizzzClicklEvent);
    on<TopicDetailStarClicklEvent>(_topicDetailStarClicklEvent);
    on<TopicDetailTypingPracticeClicklEvent>(_topicDetailTypingPracticeClicklEvent);
    on<TopicDetailUpdateClicklEvent>(_topicDetailUpdateClicklEvent);
  }

  FutureOr<void> _topicDetailInitialEvent(TopicDetailInitialEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailSuccesslState(topic: event.topic));
  }

  FutureOr<void> _topicDetailFlashCardClicklEvent(TopicDetailFlashCardClicklEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailFlashCardClicklState(topic: event.topic, total: event.total));
  }

  FutureOr<void> _topicDetailQuizzzClicklEvent(TopicDetailQuizzClicklEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailQuizzClicklState(topic: event.topic));
  }

  FutureOr<void> _topicDetailStarClicklEvent(TopicDetailStarClicklEvent event, Emitter<TopicDetailState> emit) {
    event.topic.listWords[event.index].isStar = !event.topic.listWords[event.index].isStar;
    emit(TopicDetailSuccesslState(topic: event.topic));
  }

  FutureOr<void> _topicDetailTypingPracticeClicklEvent(TopicDetailTypingPracticeClicklEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailTypingPracticeClicklState(topic: event.topic));
  }

  FutureOr<void> _topicDetailUpdateClicklEvent(TopicDetailUpdateClicklEvent event, Emitter<TopicDetailState> emit) {
    emit(TopicDetailUpdateClicklState(topic: event.topic));
  }
}
