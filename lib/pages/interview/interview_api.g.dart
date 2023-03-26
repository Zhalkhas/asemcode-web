// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChatRequest _$CreateChatRequestFromJson(Map<String, dynamic> json) =>
    CreateChatRequest(
      json['target_grade'] as String,
      json['stack'] as String,
      (json['technologies'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateChatRequestToJson(CreateChatRequest instance) =>
    <String, dynamic>{
      'target_grade': instance.targetGrade,
      'stack': instance.stack,
      'technologies': instance.technologies,
    };

CreateMessageRequest _$CreateMessageRequestFromJson(
        Map<String, dynamic> json) =>
    CreateMessageRequest(
      json['content'] as String,
    );

Map<String, dynamic> _$CreateMessageRequestToJson(
        CreateMessageRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      json['text'] as String,
      json['message_author'] as String,
      grade: json['grade'] as int?,
    );

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'message_author': instance.messageAuthor,
      'grade': instance.grade,
    };

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      json['chat_id'] as String,
      json['target_grade'] as String,
      (json['technologies'] as List<dynamic>).map((e) => e as String).toList(),
      (json['messages'] as List<dynamic>)
          .map((e) => MessageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'chat_id': instance.chatID,
      'target_grade': instance.targetGrade,
      'technologies': instance.technologies,
      'messages': instance.messages,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _InterviewApi implements InterviewApi {
  _InterviewApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://europe-central2-it-bagalau.cloudfunctions.net/chat';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ChatResponse> createChat(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ChatResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChatResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MessageResponse> createMessage(
    chatID,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MessageResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/${chatID}/message',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MessageResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
