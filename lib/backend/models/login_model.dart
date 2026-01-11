class LoginModel {
  String? message;
  Data? data;

  LoginModel({this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  User? user;
  Subscription? subscription;
  String? token;

  Data({this.user, this.subscription, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? jollyEmail;
  String? country;
  List<String>? personalizations;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.jollyEmail,
        this.country,
        this.personalizations,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    jollyEmail = json['jolly_email'];
    country = json['country'];
    personalizations = json['personalizations'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['jolly_email'] = this.jollyEmail;
    data['country'] = this.country;
    data['personalizations'] = this.personalizations;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subscription {
  int? id;
  int? userId;
  String? userrId;
  String? effectiveTime;
  String? expiryTime;
  String? updateTime;
  String? isOTC;
  String? productId;
  String? serviceId;
  String? spId;
  String? statusCode;
  dynamic chargeMode;
  dynamic chargeNumber;
  dynamic referenceId;
  Details? details;
  String? createdAt;
  String? updatedAt;

  Subscription(
      {this.id,
        this.userId,
        this.userrId,
        this.effectiveTime,
        this.expiryTime,
        this.updateTime,
        this.isOTC,
        this.productId,
        this.serviceId,
        this.spId,
        this.statusCode,
        this.chargeMode,
        this.chargeNumber,
        this.referenceId,
        this.details,
        this.createdAt,
        this.updatedAt});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userrId = json['userId'];
    effectiveTime = json['effectiveTime'];
    expiryTime = json['expiryTime'];
    updateTime = json['updateTime'];
    isOTC = json['isOTC'];
    productId = json['productId'];
    serviceId = json['serviceId'];
    spId = json['spId'];
    statusCode = json['statusCode'];
    chargeMode = json['chargeMode'];
    chargeNumber = json['chargeNumber'];
    referenceId = json['referenceId'];
    details =
    json['details'] != null ? Details.fromJson(json['details']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['userId'] = this.userId;
    data['effectiveTime'] = this.effectiveTime;
    data['expiryTime'] = this.expiryTime;
    data['updateTime'] = this.updateTime;
    data['isOTC'] = this.isOTC;
    data['productId'] = this.productId;
    data['serviceId'] = this.serviceId;
    data['spId'] = this.spId;
    data['statusCode'] = this.statusCode;
    data['chargeMode'] = this.chargeMode;
    data['chargeNumber'] = this.chargeNumber;
    data['referenceId'] = this.referenceId;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Details {
  int? id;
  String? code;
  String? title;
  int? amount;
  String? createdAt;
  String? updatedAt;

  Details(
      {this.id,
        this.code,
        this.title,
        this.amount,
        this.createdAt,
        this.updatedAt});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    title = json['title'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['code'] = this.code;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
