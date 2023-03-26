import 'package:asemcode/deferred_loader.dart';
import 'package:asemcode/pages/home/home_page.dart';
import 'package:asemcode/pages/interview/interview_page.dart'
    deferred as interview_page;
import 'package:asemcode/pages/topic_details/topic_details_page.dart'
    deferred as topic_details_page;
import 'package:qlevar_router/qlevar_router.dart';

final routes = <QRoute>[
  QRoute(path: '/', builder: () => const HomePage()),
  QRoute(
    path: '/:topicName/details',
    middleware: [
      DeferredLoader(() => topic_details_page.loadLibrary()),
    ],
    builder: () => topic_details_page.TopicDetailsPage(
      topicName: QR.params['topicName'].toString(),
    ),
  ),
  QRoute(
    path: '/:topicName/interview',
    middleware: [DeferredLoader(() => interview_page.loadLibrary())],
    builder: () => interview_page.InterviewPage(
      topicName: QR.params['topicName'].toString(),
    ),
  ),
];
