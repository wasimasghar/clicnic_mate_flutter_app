// Citation source returned alongside an assistant answer.
// A source may include a link to its reference.

/// Holds a source title, section, and optional URL.
class ChatSource {
  const ChatSource({required this.title, required this.section, this.url});
  final String title, section;
  final String? url;
  factory ChatSource.fromJson(Map<String, dynamic> json) => ChatSource(
    title: '${json['title'] ?? ''}',
    section: '${json['section'] ?? ''}',
    url: json['url'] as String?,
  );
}
