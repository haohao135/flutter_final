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
class TopicDetailFlashCardClicklEvent extends TopicDetailEvent {
  int total;
  Topic topic;
  TopicDetailFlashCardClicklEvent({required this.total, required this.topic});
}

class TopicDetailQuizzClicklEvent extends TopicDetailEvent {
  Topic topic;
  TopicDetailQuizzClicklEvent({required this.topic});
}

class TopicDetailTypingPracticeClicklEvent extends TopicDetailEvent {
  Topic topic;
  TopicDetailTypingPracticeClicklEvent({required this.topic});
}

class TopicDetailFavoriteClicklEvent extends TopicDetailEvent {
  Word word;
  TopicDetailFavoriteClicklEvent({required this.word});
}

class TopicDetailStarClicklEvent extends TopicDetailEvent {
  Topic topic;
  int index;
  TopicDetailStarClicklEvent({required this.topic, required this.index});
}

class TopicDetailErrorlEvent extends TopicDetailEvent {}
