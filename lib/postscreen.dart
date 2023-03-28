import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedagang_sukses/postdetailscreen.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> _posts = [];
  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://pedagangsukses.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100'));

    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  final _scrollController = ScrollController();
  bool _isScrolledToTop = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/pedagangsukses.png'),
        title: Text(
          'Pedagang Sukses',
          style: TextStyle(color: Color(0xFFFFD215)),
        ),
      ),
      
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostDetailsScreen(post: _posts[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.network(
                                _posts[index]
                                        ['blog_post_layout_featured_media_urls']
                                    ['full'][0],
                                // height: 200.0,
                                // width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              _posts[index]['title']['rendered']
                                  .replaceAll(RegExp('<[^>]+>'), ''),
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            
                            Text(
                              _posts[index]['content']['rendered']
                                  .replaceAll(RegExp('<[^>]+>'), ''),
                              style: TextStyle(fontSize: 16.0),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        FlutterClipboard.copy(_posts[index]['link']);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Link copied to clipboard')),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.link, color: Colors.black)
                                        ],
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xFFFFD215))),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PostDetailsScreen(
                                                    post: _posts[index]),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Baca Selengkapnya",
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xFFFFD215))),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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
