class EditorsPickModel {
  String? message;
  EditorsPickModel? data;

  EditorsPickModel({this.message, this.data});

  EditorsPickModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? EditorsPickModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? podcastId;
  String? contentUrl;
  String? title;
  String? season;
  dynamic number;
  String? pictureUrl;
  String? description;
  bool? explicit;
  int? duration;
  String? createdAt;
  String? updatedAt;
  dynamic averageRating;
  Podcast? podcast;
  String? publishedAt;

  Data(
      {this.id,
        this.podcastId,
        this.contentUrl,
        this.title,
        this.season,
        this.number,
        this.pictureUrl,
        this.description,
        this.explicit,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.averageRating,
        this.podcast,
        this.publishedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    podcastId = json['podcast_id'];
    contentUrl = json['content_url'];
    title = json['title'];
    season = json['season'];
    number = json['number'];
    pictureUrl = json['picture_url'];
    description = json['description'];
    explicit = json['explicit'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    averageRating = json['average_rating'];
    podcast =
    json['podcast'] != null ? Podcast.fromJson(json['podcast']) : null;
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['podcast_id'] = this.podcastId;
    data['content_url'] = this.contentUrl;
    data['title'] = this.title;
    data['season'] = this.season;
    data['number'] = this.number;
    data['picture_url'] = this.pictureUrl;
    data['description'] = this.description;
    data['explicit'] = this.explicit;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['average_rating'] = this.averageRating;
    if (this.podcast != null) {
      data['podcast'] = this.podcast!.toJson();
    }
    data['published_at'] = this.publishedAt;
    return data;
  }
}

class Podcast {
  int? id;
  int? userId;
  String? title;
  String? author;
  String? categoryName;
  String? categoryType;
  String? pictureUrl;
  String? coverPictureUrl;
  String? description;
  dynamic embeddablePlayerSettings;
  String? createdAt;
  String? updatedAt;

  Podcast(
      {this.id,
        this.userId,
        this.title,
        this.author,
        this.categoryName,
        this.categoryType,
        this.pictureUrl,
        this.coverPictureUrl,
        this.description,
        this.embeddablePlayerSettings,
        this.createdAt,
        this.updatedAt});

  Podcast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    author = json['author'];
    categoryName = json['category_name'];
    categoryType = json['category_type'];
    pictureUrl = json['picture_url'];
    coverPictureUrl = json['cover_picture_url'];
    description = json['description'];
    embeddablePlayerSettings = json['embeddable_player_settings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['category_name'] = this.categoryName;
    data['category_type'] = this.categoryType;
    data['picture_url'] = this.pictureUrl;
    data['cover_picture_url'] = this.coverPictureUrl;
    data['description'] = this.description;
    data['embeddable_player_settings'] = this.embeddablePlayerSettings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
