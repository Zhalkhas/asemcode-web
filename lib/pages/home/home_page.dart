import 'package:asemcode/data.dart';
import 'package:asemcode/pages/home/topic_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final topics = [
      'Roadmap',
      'Hard Skills',
      'Soft Skills',
    ];
    final subtopics = <List<String>>[
      topicsData.keys.toList(),
      [],
      [],
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Asem Code'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 90,
                            child: Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 70,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Hi, Mereke!',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const ListTile(
                        title: Text('Are you ready to learn?'),
                        subtitle: Text('Track: iOS\nTarget grade: Middle'),
                      ),
                    ],
                  ),
                )),
              )),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: CupertinoListSection(
                children: List.generate(
                  topics.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: TopicTile(
                      topic: topics[index],
                      index: index,
                      subtopics: subtopics[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
