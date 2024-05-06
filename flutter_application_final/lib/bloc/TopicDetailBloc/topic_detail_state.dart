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
