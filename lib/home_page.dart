import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  double currentOffset = 0;
  bool showUpwardButton = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('viewportDimension: ${scrollController.position.viewportDimension}');
    });
    scrollController.addListener(() {
      currentOffset = scrollController.offset;
      final maxScroll = scrollController.position.maxScrollExtent;
      log('-------------');
      log('currentOffset: $currentOffset');
      log('maxScroll: $maxScroll');
      log('viewportDimension: ${scrollController.position.viewportDimension}');
      log('=============');

      showUpwardButton = currentOffset >= 167;

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll Offset'),
        backgroundColor: Colors.grey.shade300,
      ),
      floatingActionButton: showUpwardButton
          ? FloatingActionButton.small(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            )
          : null,
      body: Stack(
        children: [
          Positioned(
            bottom: currentOffset,
            left: 0,
            right: 0,
            child: Divider(
              height: 4,
              thickness: 4,
              color: Colors.red,
            ),
          ),
          Positioned(
            height: currentOffset,
            bottom: 0,
            left: 0,
            right: 0,
            child: ColoredBox(
              color: Colors.amber.withValues(alpha: 0.2),
            ),
          ),
          ListView.builder(
            controller: scrollController,
            itemCount: 30,
            padding: EdgeInsets.all(0),
            // physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item ${index + 1}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
