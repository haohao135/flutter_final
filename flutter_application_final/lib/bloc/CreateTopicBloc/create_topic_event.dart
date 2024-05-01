part of 'create_topic_bloc.dart';

sealed class CreateTopicEvent extends Equatable {
  const CreateTopicEvent();

  @override
  List<Object> get props => [];
}

class CreateTopicEventInitial extends CreateTopicEvent{}

// ignore: must_be_immutable
class ClickFloattingButtonEvent extends CreateTopicEvent{
  int count;
  ClickFloattingButtonEvent({required this.count});
}
class ClickCompleteButtonEvent extends CreateTopicEvent{}
// ignore: must_be_immutable
class ClickScanDocumentButtonEvent extends CreateTopicEvent{
  // int count;
  // ClickScanDocumentButtonEvent({required this.count});
}
class Error extends CreateTopicEvent{}
