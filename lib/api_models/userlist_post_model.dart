class UserPost {
  final String name;
  final String job;
  final String? id;
  final String? createdAt;

  UserPost({
    required this.name,
    required this.job,
    this.id,
    this.createdAt,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) {
    return UserPost(
      name: json['name'],
      job: json['job'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
    };
  }
}
