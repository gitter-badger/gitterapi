part of gitterapi;

class RoomsResource extends Resource<V1> {
  @override
  String get path => 'rooms';

  RoomsResource(V1 v) : super(v);

  /// List rooms the current user is in.
  ///
  /// Returns [List<Map<String,dynamic>>].
  ///
  /// ### Response
  /// ```
  /// [
  ///  {
  ///    "id": "53307860c3599d1de448e19d",
  ///    "name": "Andrew Newdigate",
  ///    "topic": "",
  ///    "oneToOne": true,
  ///    "user": {
  ///      "id": "53307831c3599d1de448e19a",
  ///      "username": "suprememoocow",
  ///      "displayName": "Andrew Newdigate",
  ///      "url": "/suprememoocow",
  ///      "avatarUrlSmall": "https://avatars.githubusercontent.com/u/594566?",
  ///      "avatarUrlMedium": "https://avatars.githubusercontent.com/u/594566?"
  ///     },
  ///    "unreadItems": 0,
  ///    "mentions": 0,
  ///    "lurk": false,
  ///    "url": "/suprememoocow",
  ///    "githubType": "ONETOONE"
  ///  },
  ///  {
  ///    "id": "5330777dc3599d1de448e194",
  ///    "name": "gitterHQ",
  ///    "topic": "Gitter",
  ///    "uri": "gitterHQ",
  ///    "oneToOne": false,
  ///    "userCount": 2,
  ///    "unreadItems": 0,
  ///    "mentions": 0,
  ///    "lastAccessTime": "2014-03-24T18:22:28.105Z",
  ///    "lurk": false,
  ///    "url": "/gitterHQ",
  ///    "githubType": "ORG",
  ///    "v": 1
  ///  },
  /// ]
  /// ```
  Future<List<dynamic>> rooms({String query}) {
    return v.jsonRequest<List<dynamic>>(
      path,
      // this make sures that query values is not null.
      queryParameters: query == null ? {} : {'q': query},
    );
  }

  // TODO(@RatakondalaArun): Create a room

  /// Fetches room id from uri.
  /// `uri` must not be null.
  /// ### Example:
  /// ```
  /// String uri = 'gitterhq/sandbox';
  /// // remaining  code ......
  ///final room = getRoomIdFrom(uri);
  /// ```
  /// ### Result:
  /// ```
  /// {
  ///   "id": "52b42a52ed5ab0b3bf051b93",
  ///   "name": "gitterHQ/sandbox",
  ///   //...
  /// }
  /// ```
  ///
  Future<Map> getRoomIdFrom(String uri) {
    return v.jsonRequest<Map>('$path', method: 'POST', postData: {'uri': uri});
  }

  /// Join the room via ID.
  /// `userId` and `roomId` must not be null
  Future<void> joinRoom(String userId, String roomId) {
    return v.jsonRequest(
      'user/$userId/$path',
      method: 'POST',
      postData: {'id': roomId},
    );
  }

  /// Bans the give user form the room
  /// `roomId` and `username` must not be null.
  Future<void> banUserFromRoom(String roomId, String username) {
    return v.jsonRequest(
      '$path/$roomId/bans',
      method: 'POST',
      postData: {'username': username},
    );
  }

  /// Update room details.
  ///
  /// ### Parameters
  ///
  /// - `topic`: Room topic.
  /// - `noindex`: Whether the room is indexed by search engines.
  /// - `tags`: Tags that define the room.
  ///
  Future<void> updateRoom(
    String roomId, {
    String topic,
    bool noindex,
    List<String> tags,
  }) {
    return v.jsonRequest(
      '$path/$roomId',
      method: 'PUT',
      postData: {
        'topic': topic,
        'noindex': noindex,
        'tags': tags?.join(','),
      },
    );
  }

  ///Delete a room.
  Future<void> deleteRoom(String roomId) {
    return v.jsonRequest('$path/$roomId', method: 'DELETE');
  }

  /// List of Users currently in the room.
  ///
  /// ### Parameters
  ///
  /// All the parameters are optional:
  ///
  /// - `q`: Search query
  /// - `skip`: Skip n users.
  /// - `limit`: maximum number of users to return (default 30).
  ///
  /// ### Response
  ///
  /// ```
  /// [
  ///   {
  ///     "id": "53307734c3599d1de448e192",
  ///     "username": "malditogeek",
  ///     "displayName": "Mauro Pompilio",
  ///     "url": "/malditogeek",
  ///     "avatarUrlSmall": "https://avatars.githubusercontent.com/u/14751?",
  ///     "avatarUrlMedium": "https://avatars.githubusercontent.com/u/14751?",
  ///     "role": "admin"
  ///   },
  ///   {
  ///     "id": "53307831c3599d1de448e19a",
  ///     "username": "suprememoocow",
  ///     "displayName": "Andrew Newdigate",
  ///     "url": "/suprememoocow",
  ///     "avatarUrlSmall": "https://avatars.githubusercontent.com/u/594566?",
  ///     "avatarUrlMedium": "https://avatars.githubusercontent.com/u/594566?"
  ///   }
  /// ]
  /// ```
  Future<List<dynamic>> getUsers(
    String roomId, {
    String query,
    int skip,
    int limit = 30,
  }) {
    return v.jsonRequest(
      '$path/$roomId/users',
      queryParameters: {
        'q': query,
        'skip': skip,
        'limit': limit,
      },
    );
  }
}
