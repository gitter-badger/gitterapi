part of gitterapi;

class GroupsResource extends Resource<V1> {
  GroupsResource(V1 v) : super(v);

  @override
  String get path => 'groups';

  /// List groups the current user is in.
  Future<List> getGropus() {
    return v.jsonRequest<List>('$path');
  }

  /// List of rooms nested under the specified group.
  Future<List> getRooms(String groupId) {
    return v.jsonRequest<List>('$path/$groupId/rooms');
  }

  /// Create room nested under the specified group.
  Future<void> createRoom(
    String groupId, {
    String name,
    String topic,
    String security = 'PUBLIC',
    String type,
    String linkPath,
    String source,
  }) {
    // TODO(@RatakondalaArun): Not sure how this works
    // checkout this https://developer.gitter.im/docs/groups-resource
    return v.jsonRequest<void>(
      '$path/$groupId/rooms',
      method: 'POST',
      postData: {
        'name': name,
        'topic': topic,
        'security': {
          'security': security,
          'type': type,
          'linkPath': linkPath,
        },
        'source': source,
      },
    );
  }
}
