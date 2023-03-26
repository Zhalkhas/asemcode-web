import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'interview_api.g.dart';

@RestApi(baseUrl: "https://europe-central2-it-bagalau.cloudfunctions.net/chat")
abstract class InterviewApi {
  factory InterviewApi(Dio dio) = _InterviewApi;
  @POST('/')
  Future<ChatResponse> createChat(@Body() CreateChatRequest request);
  @POST('/{chatID}/message')
  Future<MessageResponse> createMessage(
    @Path('chatID') String chatID,
    @Body() CreateMessageRequest request,
  );
}

@immutable
@JsonSerializable()
class CreateChatRequest {
  @JsonKey(name: 'target_grade')
  final String targetGrade;
  final String stack;
  final List<String> technologies;

  const CreateChatRequest(this.targetGrade, this.stack, this.technologies);

  factory CreateChatRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChatRequestToJson(this);
}

@immutable
@JsonSerializable()
class CreateMessageRequest {
  final String content;

  const CreateMessageRequest(this.content);

  factory CreateMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateMessageRequestToJson(this);
}

@immutable
@JsonSerializable()
class MessageResponse {
  final String text;
  @JsonKey(name: 'message_author')
  final String messageAuthor;
  final int? grade;

  const MessageResponse(this.text, this.messageAuthor, {this.grade});

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@immutable
@JsonSerializable()
class ChatResponse {
  @JsonKey(name: 'chat_id')
  final String chatID;
  @JsonKey(name: 'target_grade')
  final String targetGrade;
  final List<String> technologies;
  final List<MessageResponse> messages;

  const ChatResponse(
    this.chatID,
    this.targetGrade,
    this.technologies,
    this.messages,
  );

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
