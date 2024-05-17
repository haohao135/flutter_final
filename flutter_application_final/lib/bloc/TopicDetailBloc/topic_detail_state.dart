part of 'topic_detail_bloc.dart';

sealed class TopicDetailState{
  const TopicDetailState();}

class TopicDetailActionState extends TopicDetailState{}


class TopicDetailInitialState extends TopicDetailState{}
class TopicDetailLoadinglState extends TopicDetailState{}
class TopicDetailSuccesslState extends TopicDetailState{
  Topic topic;
  TopicDetailSuccesslState({required this.topic});
}
class TopicDetailErrorlState extends TopicDetailState{}
class TopicDetailFlashCardClicklState extends TopicDetailActionState{
  int total;
  Topic topic;
  TopicDetailFlashCardClicklState({required this.total, required this.topic});
}

class TopicDetailQuizzClicklState extends TopicDetailActionState{
  Topic topic;
  TopicDetailQuizzClicklState({required this.topic});
}

class TopicDetailTypingPracticeClicklState extends TopicDetailActionState{
  Topic topic;
  TopicDetailTypingPracticeClicklState({required this.topic});
}

class TopicDetailUpdateClicklState extends TopicDetailActionState{
  Topic topic;
  TopicDetailUpdateClicklState({required this.topic});
}

class TopicDetailDeleteClicklState extends TopicDetailActionState{
  Topic topic;
  TopicDetailDeleteClicklState({required this.topic});
}

class TopicDetailResultUserClicklState extends TopicDetailActionState{
  Topic topic;
  TopicDetailResultUserClicklState({required this.topic});
}

class TopicDetailFavoriteClicklState extends TopicDetailState{}