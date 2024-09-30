class NotificationEntity {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final bool? isRead;
  late final String? id,
      userId,
      type,
      title,
      body,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  NotificationEntity(
      {this.id = "",
      this.userId = "",
      this.type = "",
      this.title = "",
      this.body = "",
      this.createAt = "",
      this.isRead = false});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'title': title,
        'body': body,
        'createAt': createAt,
        'isRead': isRead,
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static NotificationEntity fromJson(Map json) {
    return NotificationEntity(
        id: json['id'] as String,
        userId: json['userId'] as String,
        type: json['type'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        isRead: json['isRead'] as bool,
        createAt: json['createAt'] as String);
  }
}
