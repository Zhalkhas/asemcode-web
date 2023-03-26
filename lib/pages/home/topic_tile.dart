import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopicTile extends StatefulWidget {
  final String topic;
  final int index;
  final List<String> subtopics;
  const TopicTile({
    Key? key,
    required this.topic,
    required this.index,
    required this.subtopics,
  }) : super(key: key);

  @override
  State<TopicTile> createState() => _TopicTileState();
}

class _TopicTileState extends State<TopicTile> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoListTile(
          onTap: widget.subtopics.isEmpty
              ? () => QR.to('/${widget.topic}/interview')
              : () => setState(() => expanded = !expanded),
          title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/level${widget.index + 1}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${widget.index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.topic,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  if (widget.subtopics.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Transform.rotate(
                        angle: expanded ? pi / 2 : 0,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.right_chevron,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (expanded && widget.subtopics.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
                children: widget.subtopics
                    .mapIndexed<Widget>((index, e) => CupertinoListTile(
                          onTap: () => QR.to('$e/details'),
                          leading: Text('${widget.index + 1}.${index + 1}'),
                          title: Text(e),
                        ))
                    .toList()),
          ),
      ],
    );
  }
}
