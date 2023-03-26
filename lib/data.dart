class TopicData {
  final String description;
  final List<String> imageUrls;
  final List<Uri> usefulLinks;

  const TopicData(this.description, this.imageUrls, this.usefulLinks);
}

final topicsData = {
  'UIKit': TopicData(
      'UIKit provides a variety of features for building apps, '
      'including components you can use to construct '
      'the core infrastructure of your iOS, iPadOS, or tvOS apps. '
      'The framework provides the window and view architecture '
      'for implementing your UI, the event-handling infrastructure '
      'for delivering Multi-Touch and other types of input to your app, '
      'and the main run loop for managing interactions between the user, '
      'the system, and your app.',
      [
        'https://docs-assets.developer.apple.com/published/c08fbab88e/rendered2x-1661916506.png',
        'https://www.appcoda.com/learnswiftui/images/uikit/swiftui-uikit-1.png',
      ],
      [
        Uri.parse('https://developer.apple.com/documentation/uikit'),
        Uri.parse('https://swiftbook.ru/contents/uikit-framework/'),
        Uri.parse(
          'https://www.hackingwithswift.com/read/8/2/building-a-uikit-user-interface-programmatically',
        ),
      ]),
};
