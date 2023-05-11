import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String id;
  String postId;
  String userId;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
  });

  // factory Like.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map<String, dynamic>;
  //   return Like(
  //     id: doc.id,
  //     postId: data['postId'],
  //     userId: data['userId'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'post': postId,
      'userId': userId,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
    );
  }
}
