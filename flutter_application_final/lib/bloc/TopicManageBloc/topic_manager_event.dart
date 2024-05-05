part of 'topic_manager_bloc.dart';

sealed class TopicManagerEvent {
  const TopicManagerEvent();
}

class InitialTopicManagerEvent extends TopicManagerEvent{
  List<Topic>? topicList = [];
  late bool hasTopic;
  InitialTopicManagerEvent({required this.hasTopic, this.topicList});
}
class LoadingTopicManagerEvent extends TopicManagerEvent{}
class CreateTopicManagerEvent extends TopicManagerEvent{}
class DetailTopicManagerEventClickEvent extends TopicManagerEvent{
  Topic topic;
  DetailTopicManagerEventClickEvent({required this.topic});
}

class DeleteTopicManagerEvent extends TopicManagerEvent{
  List<Topic>? topicList = [];
  Topic topic;
  DeleteTopicManagerEvent({required this.topic, this.topicList});
}
