part of 'create_topic_bloc.dart';

sealed class CreateTopicState extends Equatable {
  const CreateTopicState();
  
  @override
  List<Object> get props => [];
}

final class CreateTopicActionState extends CreateTopicState {}


final class CreateTopicInitial extends CreateTopicState {
  final List<Object> listTopicDTO = [];

}
final class CreateTopicError extends CreateTopicState {}
final class CreateTopicIsLoading extends CreateTopicState {}
final class CreateTopicIsSuccess extends CreateTopicState {
  final int count;
  const CreateTopicIsSuccess({required this.count});
}
final class CreateTopicScanDocumentClick extends CreateTopicActionState {}

