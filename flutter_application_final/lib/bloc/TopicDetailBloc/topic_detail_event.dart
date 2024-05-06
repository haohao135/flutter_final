part of 'topic_detail_bloc.dart';

sealed class TopicDetailEvent {
  const TopicDetailEvent();
}

class TopicDetailInitialEvent extends TopicDetailEvent {
  Topic topic;
  TopicDetailInitialEvent({required this.topic});
}

class TopicDetailLoadinglEvent extends TopicDetailEvent {}

class TopicDetailSuccesslEvent extends TopicDetailEvent {
  Topic topic;
  TopicDetailSuccesslEvent({required this.topic});
}

class TopicDetailErrorlEvent extends TopicDetailEvent {}
