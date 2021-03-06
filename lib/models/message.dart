import 'issue.dart';
import 'mention.dart';
import 'user.dart';

class Message {
  ///  ID of the message.
  final String id;

  ///  Original message in plain-text/markdown.
  final String text;

  ///  HTML formatted message.
  final String html;

  ///  ISO formatted date of the message.
  final String sent;

  ///  ISO formatted date of the message if edited.
  final String editedAt;

  ///  (User)[user-resource] that sent the message.
  final User fromUser;

  ///  Boolean that indicates if the current user has read the message.
  final bool unread;

  ///  Number of users that have read the message.
  final int readBy;

  ///  List of URLs present in the message.
  final List<String> urls;

  ///  List of @Mentions in the message.
  final List<Mention> mentions;

  ///  List of #Issues referenced in the message.
  final List<Issue> issues;

  ///  Metadata. This is currently not used for anything.
  final List<dynamic> meta;

  DateTime get sentAs {
    return sentAs == null ? null : DateTime.tryParse(sent);
  }

  DateTime get editedAtAs {
    return editedAt == null ? null : DateTime.tryParse(editedAt);
  }

  const Message({
    this.id,
    this.text,
    this.html,
    this.sent,
    this.editedAt,
    this.fromUser,
    this.unread,
    this.readBy,
    this.urls,
    this.mentions,
    this.issues,
    this.meta,
  });

  factory Message.fromMap(Map map) {
    if (map == null) return null;
    return Message(
      id: map['id'],
      text: map['text'],
      html: map['html'],
      sent: map['sent'],
      editedAt: map['editedAt'],
      fromUser: User.fromMap(map['fromUser']),
      unread: map['unread'],
      readBy: map['readBy'],
      urls: List.castFrom<dynamic, String>(map['urls'] ?? []),
      mentions: List.from(map['mentions'] ?? [])
          .map<Mention>((m) => Mention.fromMap(m as Map))
          .toList(),
      issues: List.from(map['issues'] ?? [])
          .map<Issue>((m) => Issue.fromMap(m))
          .toList(),
      meta: map['meta'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'html': html,
      'sent': sent,
      'editedAt': editedAt,
      'fromUser': fromUser?.toMap(),
      'unread': unread,
      'readBy': readBy,
      'urls': urls,
      'mentions': mentions?.map((m) => m?.toMap())?.toList() ?? <Map>[],
      'issues': issues?.map((m) => m?.toMap())?.toList() ?? <Map>[],
      'meta': meta,
    };
  }

  Message copyWith({
    String id,
    String text,
    String html,
    String sent,
    String editedAt,
    User fromUser,
    bool unread,
    int readBy,
    List<String> urls,
    List<Mention> mentions,
    List<Issue> issues,
    Map meta,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      html: html ?? this.html,
      sent: sent ?? this.sent,
      editedAt: editedAt ?? this.editedAt,
      fromUser: fromUser ?? this.fromUser,
      unread: unread ?? this.unread,
      readBy: readBy ?? this.readBy,
      urls: urls ?? this.urls,
      mentions: mentions ?? this.mentions,
      issues: issues ?? this.issues,
      meta: meta ?? this.meta,
    );
  }
}
