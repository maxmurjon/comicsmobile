import 'package:flutter/material.dart';

class ComicList extends StatelessWidget {
  final List<String> comics;

  const ComicList({Key? key, required this.comics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "Similar Comics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comics.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(comics[index]),
            );
          },
        ),
      ],
    );
  }
}
