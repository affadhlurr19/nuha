import 'dart:convert';

DetailArtikel detailArtikelFromJson(String str) => DetailArtikel.fromJson(json.decode(str));

String detailArtikelToJson(DetailArtikel data) => json.encode(data.toJson());

class DetailArtikel {
    DetailArtikel({
        required this.code,
        required this.message,
        required this.founded,
        required this.article,
    });

    int code;
    String message;
    int founded;
    Article article;

    factory DetailArtikel.fromJson(Map<String, dynamic> json) => DetailArtikel(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        article: Article.fromJson(json["article"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "article": article.toJson(),
    };
}

class Article {
    Article({
        required this.id,
        required this.title,
        required this.category,
        required this.content,
        required this.imageUrl,
        required this.author,
        required this.readTime,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String title;
    String category;
    String content;
    String imageUrl;
    String author;
    int readTime;
    DateTime createdAt;
    DateTime updatedAt;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        content: json["content"],
        imageUrl: json["image_url"],
        author: json["author"],
        readTime: json["read_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "content": content,
        "image_url": imageUrl,
        "author": author,
        "read_time": readTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
