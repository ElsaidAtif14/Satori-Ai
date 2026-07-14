class UserEntity {
  final String name;
  final String email;
  final String uId;
  final String? imageUrl;

  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
    this.imageUrl,
  });

  // ignore: strict_top_level_inference
}
