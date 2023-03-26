import 'package:asemcode/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicDetailsPage extends StatefulWidget {
  final String topicName;
  const TopicDetailsPage({Key? key, required this.topicName}) : super(key: key);

  @override
  State<TopicDetailsPage> createState() => _TopicDetailsPageState();
}

class _TopicDetailsPageState extends State<TopicDetailsPage>
    with SingleTickerProviderStateMixin {
  late final TopicData topicData;
  late final _tabController =
      TabController(length: topicData.imageUrls.length, vsync: this);
  @override
  void initState() {
    super.initState();
    final topicData = topicsData[widget.topicName];
    if (topicData == null) {
      QR.navigator.replaceLast('/404');
    } else {
      this.topicData = topicData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => QR.navigator.replaceAll('/'),
        ),
        title: const Text('Asem Code'),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () => QR.to('/${widget.topicName}/interview'),
            icon: const Icon(
              CupertinoIcons.person_2,
              color: Colors.white,
            ),
            label: Text(
              'Take Interview',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.topicName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  onPageChanged: (index) =>
                                      _tabController.animateTo(index),
                                  itemBuilder: (context, index) =>
                                      Image.network(topicData.imageUrls[index]),
                                  itemCount: topicData.imageUrls.length,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TabPageSelector(
                                    controller: _tabController,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36),
                          child: Text(
                            topicData.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        if (topicData.usefulLinks.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Text(
                              'Useful Links',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ...topicData.usefulLinks.map((e) => GestureDetector(
                            onTap: () => launchUrl(e),
                            child: Text(
                              e.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                            )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
