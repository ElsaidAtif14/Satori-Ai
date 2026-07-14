class SatoriFeature {
  final String id;
  final String title;
  final String description;
  final String tag; // مثل: Focus, Calm, Productivity

  SatoriFeature({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
  });

  // تحويل الـ JSON القادم من الـ API إلى Model (تستخدمه في الـ Repository/Provider)
  factory SatoriFeature.fromJson(Map<String, dynamic> json) {
    return SatoriFeature(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tag: json['tag'] as String,
    );
  }

  // تحويل الـ Model إلى JSON (إذا كنت ستقوم بعمل POST للبيانات)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tag': tag,
    };
  }
}

final List<SatoriFeature> satoriFeaturesList = [
  SatoriFeature(
    id: '1',
    title: 'Evolution of Focus',
    description: 'Unlock a higher state of productivity with Satori AI. Clear the mental clutter and find your ultimate workflow.',
    tag: 'Focus',
  ),
  SatoriFeature(
    id: '2',
    title: 'Redefine Efficiency',
    description: 'Bring peace to your chaotic workday and elevate your output effortlessly with Satori AI.',
    tag: 'Calm',
  ),
  SatoriFeature(
    id: '3',
    title: 'Intelligent Design',
    description: 'Satori AI: Where deep focus meets intelligent design. Calm your mind, master your time, and achieve more.',
    tag: 'Productivity',
  ),
];