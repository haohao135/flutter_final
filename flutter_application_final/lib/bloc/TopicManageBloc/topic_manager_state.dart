part of 'topic_manager_bloc.dart';

sealed class TopicManagerState{
}

final class TopicManagerActionState extends TopicManagerState {}

final class TopicManagerInitialState extends TopicManagerState {}
final class TopicManagerNoTopicState extends TopicManagerState {}
final class TopicManagerSuccessState extends TopicManagerState {
  List<Topic> topicList = [];
  TopicManagerSuccessState({required this.topicList});
}
final class TopicManagerLoadingState extends TopicManagerState {}
final class TopicManagerErrorState extends TopicManagerState {}

final class DetailTopicManagerEventClickState extends TopicManagerActionState {
  Topic topic;
  DetailTopicManagerEventClickState({required this.topic});
}
class DeleteTopicManagerState extends TopicManagerEvent{
  Topic topic;
  DeleteTopicManagerState({required this.topic});
}
