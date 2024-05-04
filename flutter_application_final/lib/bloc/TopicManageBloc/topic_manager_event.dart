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
