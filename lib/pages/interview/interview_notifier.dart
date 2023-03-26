import 'package:asemcode/pages/interview/interview_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class InterviewNotifier extends ValueNotifier<InterviewState> {
  final InterviewApi interviewApi = InterviewApi(
    Dio()
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      ),
  );

  InterviewState get state => value;
  set state(InterviewState value) {
    print('setting state to $value');
    this.value = value;
  }

  InterviewNotifier() : super(InterviewState.initial());

  Future<void> startInterview(List<String> topics) async {
    state = InterviewState.loading(const [], chatID: '');
    try {
      final chatResponse = await interviewApi
          .createChat(CreateChatRequest('Middle', 'iOS', topics));
      state = InterviewState.chatting(
        chatResponse.messages,
        chatID: chatResponse.chatID,
      );
    } catch (e) {
      state = InterviewState.error(state.messages, e, chatID: state.chatID);
    }
  }

  Future<void> sendMessage(String content) async {
    state = InterviewState.loading(
        [...state.messages, MessageResponse(content, 'user')],
        chatID: state.chatID);
    try {
      final messageResponse = await interviewApi.createMessage(
          state.chatID, CreateMessageRequest(content));
      state = InterviewState.chatting(
        [...state.messages, messageResponse],
        chatID: state.chatID,
      );
    } catch (e) {
      state = InterviewState.error(state.messages, e, chatID: state.chatID);
    }
  }
}

@immutable
class InterviewState {
  final String chatID;
  final List<MessageResponse> messages;
  final bool isLoading;
  final Object? error;
  InterviewState._({
    required List<MessageResponse> messages,
    required this.isLoading,
    this.error,
    required this.chatID,
  }) : messages = List.unmodifiable(
            messages.where((element) => element.messageAuthor != 'system'));

  factory InterviewState.initial() => InterviewState._(
        messages: [],
        isLoading: false,
        error: null,
        chatID: '',
      );

  factory InterviewState.loading(
    List<MessageResponse> messages, {
    required String chatID,
  }) =>
      InterviewState._(
        chatID: chatID,
        messages: messages,
        isLoading: true,
        error: null,
      );

  factory InterviewState.error(
    List<MessageResponse> messages,
    Object error, {
    required String chatID,
  }) =>
      InterviewState._(
        chatID: chatID,
        messages: messages,
        isLoading: false,
        error: error,
      );

  factory InterviewState.chatting(
    List<MessageResponse> messages, {
    required String chatID,
  }) =>
      InterviewState._(
        chatID: chatID,
        messages: messages,
        isLoading: false,
        error: null,
      );

  InterviewState copyWith(
          {String? chatID,
          List<MessageResponse>? messages,
          bool? isLoading,
          Object? error}) =>
      InterviewState._(
        chatID: chatID ?? this.chatID,
        messages: messages ?? this.messages,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  String toString() {
    return 'InterviewState{chatID: $chatID, messages: [${messages.length}], isLoading: $isLoading, error: $error}';
  }
}
