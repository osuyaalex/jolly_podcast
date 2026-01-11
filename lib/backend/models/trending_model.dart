class TrendingResponseModel{
  String? message;
  TrendingModel? data;

  TrendingResponseModel({this.message, this.data});

  TrendingResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? TrendingModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class TrendingModel {
  String? message;
  PaginatedData? data;

  TrendingModel({this.message, this.data});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
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

class PaginatedData {
  List<EpisodeData>? data;
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  PaginatedData(
      {this.data,
        this.currentPage,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  PaginatedData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EpisodeData>[];
      for (var v in json['data']) {
        data!.add(EpisodeData.fromJson(v));
      }
    }
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      for (var v in json['links']) {
        links!.add(Links.fromJson(v));
      }
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class EpisodeData {
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
  int? playCount;
  int? likeCount;
  dynamic averageRating;
  Podcast? podcast;
  String? publishedAt;

  EpisodeData(
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
        this.playCount,
        this.likeCount,
        this.averageRating,
        this.podcast,
        this.publishedAt});

  EpisodeData.fromJson(Map<String, dynamic> json) {
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
    playCount = json['play_count'];
    likeCount = json['like_count'];
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
    data['play_count'] = this.playCount;
    data['like_count'] = this.likeCount;
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
  String? embeddablePlayerSettings;
  String? createdAt;
  String? updatedAt;
  Publisher? publisher;

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
        this.updatedAt,
        this.publisher});

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
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
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
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.toJson();
    }
    return data;
  }
}

class Publisher {
  int? id;
  String? firstName;
  String? lastName;
  String? companyName;
  String? email;
  String? profileImageUrl;
  String? createdAt;
  String? updatedAt;

  Publisher(
      {this.id,
        this.firstName,
        this.lastName,
        this.companyName,
        this.email,
        this.profileImageUrl,
        this.createdAt,
        this.updatedAt});

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyName = json['company_name'];
    email = json['email'];
    profileImageUrl = json['profile_image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['profile_image_url'] = this.profileImageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}




