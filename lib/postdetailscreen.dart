import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final dynamic post;

  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFD215)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          post['title']['rendered'].replaceAll(RegExp('<[^>]+>'), ''),
          style: TextStyle(color: Color(0xFFFFD215)),
        ),
      ),
      body: SingleChildScrollView(
        controller:  _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                post['blog_post_layout_featured_media_urls']['full'][0],
                // height: 200.0,
                // width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0),
              child: Row(
                children: [
                  Text("By: "+post['_embedded']['author'][0]['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 15),
                  Text(post['date']),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                post['content']['rendered'].replaceAll(RegExp('<[^>]+>'), ''),
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        child: Icon(
          Icons.arrow_upward,
          color: Color(0xFFFFD215),
        ),
      ),
    );
  }
}
