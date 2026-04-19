import 'package:get/get.dart';
import 'package:train_kotai/app/data/models/post_model.dart';

class FeedController extends GetxController {
  final posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialPosts();
  }

  void _loadInitialPosts() {
    posts.addAll([
      Post(
        id: '1',
        userName: 'Al Muntakim',
        time: '3 Min',
        content: 'The Egarosindhur Probhati just leaves Dhaka for Kishoreganj.',
        imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=2070&auto=format&fit=crop',
        likes: 35,
        comments: 12,
        shares: 234,
      ),
      Post(
        id: '2',
        userName: 'Sabbir Ahmed',
        time: '15 Min',
        content: 'Finally on the way to Chittagong! The weather is amazing today.',
        imageUrl: 'https://images.unsplash.com/photo-1474487548417-781cb71495f3?q=80&w=2184&auto=format&fit=crop',
        likes: 12,
        comments: 5,
        shares: 45,
      ),
    ]);
  }

  void likePost(String postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = posts[index];
      if (post.isLiked) {
        post.likes--;
        post.isLiked = false;
      } else {
        post.likes++;
        post.isLiked = true;
      }
      posts[index] = post; // Trigger UI update
    }
  }

  void addPost(Post post) {
    posts.insert(0, post);
  }
}
