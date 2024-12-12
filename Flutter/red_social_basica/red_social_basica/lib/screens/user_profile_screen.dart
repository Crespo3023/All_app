import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'post_detail_screen.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;
  final ApiService apiService = ApiService();
  UserProfileScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
// Información del usuario
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              child: Text(user.name.substring(0, 1)),
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('@${user.username}'),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(user.email),
            ),
            Divider(),
// Publicaciones del usuario
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Publicaciones',
                style: TextStyle(fontSize: 18),
              ),
            ),
            FutureBuilder<List<Post>>(
              future: apiService.getPostsByUser(user.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post> posts = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostDetailScreen(post: posts[index]),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error:${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
