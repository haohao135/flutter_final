part of 'create_topic_bloc.dart';

sealed class CreateTopicEvent{
  const CreateTopicEvent();
}

class CreateTopicEventInitial extends CreateTopicEvent{}
class UpdateTopicEventInitial extends CreateTopicEvent{
  late int count;
  UpdateTopicEventInitial({required this.count});
}

// ignore: must_be_immutable
class ClickFloattingButtonEvent extends CreateTopicEvent{
  int count;
  ClickFloattingButtonEvent({required this.count});
}
class ClickCompleteButtonEvent extends CreateTopicEvent{}
// ignore: must_be_immutable
class ClickScanDocumentButtonEvent extends CreateTopicEvent{
}
class Error extends CreateTopicEvent{}
