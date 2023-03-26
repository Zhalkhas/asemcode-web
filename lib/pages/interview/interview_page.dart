import 'package:asemcode/pages/interview/interview_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class InterviewPage extends StatefulWidget {
  final String topicName;
  const InterviewPage({Key? key, required this.topicName}) : super(key: key);

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  final interviewNotifier = InterviewNotifier();
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => QR.navigator.replaceAll('/'),
        ),
        title: const Text('Asem Code: Interview'),
        centerTitle: false,
      ),
      bottomSheet: ValueListenableBuilder(
        valueListenable: interviewNotifier,
        builder: (BuildContext context, InterviewState state, Widget? child) {
          final messages = state.messages;
          return messages.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Type your message',
                                ),
                                controller: _messageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await interviewNotifier
                                      .sendMessage(_messageController.text);
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeIn,
                                  );
                                  _messageController.clear();
                                },
                                icon: state.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Icon(
                                        CupertinoIcons.paperplane_fill)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: interviewNotifier,
        builder: (BuildContext context, InterviewState state, Widget? child) {
          final messages = state.messages;
          if (messages.isEmpty) {
            return Center(
              child: CupertinoButton(
                child: const Text('Start interview'),
                onPressed: () =>
                    interviewNotifier.startInterview([widget.topicName]),
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ) +
                  EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                  ),
              controller: _scrollController,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 24),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages.elementAt(index);
                return ListTile(
                  leading: message.messageAuthor == 'user'
                      ? const Icon(CupertinoIcons.person_alt_circle_fill)
                      : const Icon(CupertinoIcons.globe),
                  title: Text(message.text),
                );
              },
            );
          }
        },
      ),
    );
  }
}
