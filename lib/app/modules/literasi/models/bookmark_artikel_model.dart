import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  final String id;
  final String postId;
  final String userId;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
  });

  factory Like.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Like(
      id: doc.id,
      postId: data['postId'],
      userId: data['userId'],
    );
  }
}