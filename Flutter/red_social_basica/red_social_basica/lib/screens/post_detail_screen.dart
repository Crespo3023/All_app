import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/comment.dart';
import '../services/api_service.dart';
import 'add_comment_screen.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  PostDetailScreen({required this.post});
  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  ApiService apiService = ApiService();
  late Future<List<Comment>> futureComments;

  @override
  void initState() {
    super.initState();
    futureComments = apiService.getComments(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Publicación'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(widget.post.title),
              subtitle: Text(widget.post.body),
            ),
            Divider(),
            Text('Comentarios', style: TextStyle(fontSize: 18)),
            FutureBuilder<List<Comment>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Comment> comments = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            comments[index].name.substring(0, 1),
                          ),
                        ),
                        title: Text(comments[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comments[index].body),
                            SizedBox(height: 4),
                            Text(
                              comments[index].email,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCommentScreen(postId: widget.post.id),
            ),
          );
          if (result != null) {
            // Actualizamos la lista de comentarios
            setState(() {
              futureComments = apiService.getComments(widget.post.id);
            });
          }
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
