class MarketingInfModel {
  bool? status;
  String? message;
  Data? data;

  MarketingInfModel({this.status, this.message, this.data});

  MarketingInfModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic referralLink;
  dynamic referralCode;
  dynamic earning;
  dynamic totalOrders;
  List<MerketingOrderList>? orderList;
  List<UsersList>? usersList;

  Data(
      {this.referralLink,
        this.referralCode,
        this.earning,
        this.totalOrders,
        this.orderList,
        this.usersList});

  Data.fromJson(Map<String, dynamic> json) {
    referralLink = json['referral_link'];
    referralCode = json['referral_code'];
    earning = json['earning'];
    totalOrders = json['total_orders'];
    if (json['order_list'] != null) {
      orderList = <MerketingOrderList>[];
      json['order_list'].forEach((v) {
        orderList!.add(new MerketingOrderList.fromJson(v));
      });
    }
    if (json['users_list'] != null) {
      usersList = <UsersList>[];
      json['users_list'].forEach((v) {
        usersList!.add(new UsersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referral_link'] = this.referralLink;
    data['referral_code'] = this.referralCode;
    data['earning'] = this.earning;
    data['total_orders'] = this.totalOrders;
    if (this.orderList != null) {
      data['order_list'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    if (this.usersList != null) {
      data['users_list'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerketingOrderList {
  int? orderId;
  dynamic name;
  dynamic phone;
  Address? address;
  dynamic orderAmount;
  dynamic commissionMarketingPartner;
  dynamic date;

  MerketingOrderList(
      {this.orderId,
        this.name,
        this.phone,
        this.address,
        this.orderAmount,
        this.commissionMarketingPartner,
        this.date});

  MerketingOrderList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    name = json['name'];
    phone = json['phone'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderAmount = json['order_amount'];
    commissionMarketingPartner = json['commission_marketing_partner'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_amount'] = this.orderAmount;
    data['commission_marketing_partner'] = this.commissionMarketingPartner;
    data['date'] = this.date;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic street;
  dynamic landmark;
  dynamic addressType;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.street,
        this.landmark,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    street = json['street'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class UsersList {
  dynamic name;
  dynamic phone;
  dynamic profileImage;

  UsersList({this.name, this.phone, this.profileImage});

  UsersList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
