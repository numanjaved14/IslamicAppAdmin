import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  var snap;
  NewsWidget({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.all(5),
        child: ListTile(
          leading: Image(
            image: NetworkImage(snap['photoUrl']),
          ),
          title: Text(
            snap['title'],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snap['description'],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                snap['date'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
