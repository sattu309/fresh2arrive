// class CheckOutDataModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   CheckOutDataModel({this.status, this.message, this.data});
//
//   CheckOutDataModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic orderId;
//   dynamic itemTotal;
//   dynamic surcharge;
//   dynamic tax;
//   dynamic deliveryCharges;
//   dynamic packingFee;
//   dynamic tipAmount;
//   dynamic couponDiscount;
//   dynamic commissionDriver;
//   dynamic commissionAdmin;
//   dynamic grandTotal;
//   dynamic  user;
//   dynamic  vendor;
//   dynamic driver;
//   Address? address;
//   String? orderType;
//   String? deliveryStatus;
//   List<OrderItems>? orderItems;
//   String? placedAt;
//
//   Data(
//       {this.orderId,
//         this.itemTotal,
//         this.surcharge,
//         this.tax,
//         this.deliveryCharges,
//         this.packingFee,
//         this.tipAmount,
//         this.couponDiscount,
//         this.commissionDriver,
//         this.commissionAdmin,
//         this.grandTotal,
//         this.user,
//         this.vendor,
//         this.driver,
//         this.address,
//         this.orderType,
//         this.deliveryStatus,
//         this.orderItems,
//         this.placedAt});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     orderId = json['order_id'];
//     itemTotal = json['item_total'];
//     surcharge = json['surcharge'];
//     tax = json['tax'];
//     deliveryCharges = json['delivery_charges'];
//     packingFee = json['packing_fee'];
//     tipAmount = json['tip_amount'];
//     couponDiscount = json['coupon_discount'];
//     commissionDriver = json['commission_driver'];
//     commissionAdmin = json['commission_admin'];
//     grandTotal = json['grand_total'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     vendor = json['vendor'] != null ? User.fromJson(json['vendor']) : null;
//     driver = json['driver'];
//     address =
//     json['address'] != null ? Address.fromJson(json['address']) : null;
//     orderType = json['order_type'];
//     deliveryStatus = json['delivery_status'];
//     if (json['order_items'] != null) {
//       orderItems = <OrderItems>[];
//       json['order_items'].forEach((v) {
//         orderItems!.add(OrderItems.fromJson(v));
//       });
//     }
//     placedAt = json['placed_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['order_id'] = orderId;
//     data['item_total'] = itemTotal;
//     data['surcharge'] = surcharge;
//     data['tax'] = tax;
//     data['delivery_charges'] = deliveryCharges;
//     data['packing_fee'] = packingFee;
//     data['tip_amount'] = tipAmount;
//     data['coupon_discount'] = couponDiscount;
//     data['commission_driver'] = commissionDriver;
//     data['commission_admin'] = commissionAdmin;
//     data['grand_total'] = grandTotal;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     if (vendor != null) {
//       data['vendor'] = vendor!.toJson();
//     }
//     data['driver'] = driver;
//     if (address != null) {
//       data['address'] = address!.toJson();
//     }
//     data['order_type'] = orderType;
//     data['delivery_status'] = deliveryStatus;
//     if (orderItems != null) {
//       data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
//     }
//     data['placed_at'] = placedAt;
//     return data;
//   }
// }
//
// class User {
//   dynamic id;
//   dynamic isDriver;
//   dynamic isVendor;
//   dynamic walletBalance;
//   dynamic earnedBalance;
//   String? name;
//   String? phone;
//   String? email;
//   int? otp;
//   String? profileImage;
//   String? latitude;
//   String? longitude;
//   String? location;
//   dynamic defaultAddress;
//   String? referalCode;
//   dynamic deviceToken;
//   dynamic deviceId;
//   dynamic isDriverOnline;
//   dynamic isVendorOnline;
//   dynamic deliveryRange;
//   dynamic selfDelivery;
//   dynamic adminCommission;
//   dynamic asDriverVerified;
//   dynamic asVendorVerified;
//   dynamic featuredStore;
//   dynamic emailVerifiedAt;
//   int? status;
//   int? isProfileComplete;
//   String? createdAt;
//   String? updatedAt;
//   dynamic deletedAt;
//
//   User(
//       {this.id,
//         this.isDriver,
//         this.isVendor,
//         this.walletBalance,
//         this.earnedBalance,
//         this.name,
//         this.phone,
//         this.email,
//         this.otp,
//         this.profileImage,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.defaultAddress,
//         this.referalCode,
//         this.deviceToken,
//         this.deviceId,
//         this.isDriverOnline,
//         this.isVendorOnline,
//         this.deliveryRange,
//         this.selfDelivery,
//         this.adminCommission,
//         this.asDriverVerified,
//         this.asVendorVerified,
//         this.featuredStore,
//         this.emailVerifiedAt,
//         this.status,
//         this.isProfileComplete,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     isDriver = json['is_driver'];
//     isVendor = json['is_vendor'];
//     walletBalance = json['wallet_balance'];
//     earnedBalance = json['earned_balance'];
//     name = json['name'];
//     phone = json['phone'];
//     email = json['email'];
//     otp = json['otp'];
//     profileImage = json['profile_image'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     defaultAddress = json['default_address'];
//     referalCode = json['referal_code'];
//     deviceToken = json['device_token'];
//     deviceId = json['device_id'];
//     isDriverOnline = json['is_driver_online'];
//     isVendorOnline = json['is_vendor_online'];
//     deliveryRange = json['delivery_range'];
//     selfDelivery = json['self_delivery'];
//     adminCommission = json['admin_commission'];
//     asDriverVerified = json['as_driver_verified'];
//     asVendorVerified = json['as_vendor_verified'];
//     featuredStore = json['featured_store'];
//     emailVerifiedAt = json['email_verified_at'];
//     status = json['status'];
//     isProfileComplete = json['is_profile_complete'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['is_driver'] = isDriver;
//     data['is_vendor'] = isVendor;
//     data['wallet_balance'] = walletBalance;
//     data['earned_balance'] = earnedBalance;
//     data['name'] = name;
//     data['phone'] = phone;
//     data['email'] = email;
//     data['otp'] = otp;
//     data['profile_image'] = profileImage;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['location'] = location;
//     data['default_address'] = defaultAddress;
//     data['referal_code'] = referalCode;
//     data['device_token'] = deviceToken;
//     data['device_id'] = deviceId;
//     data['is_driver_online'] = isDriverOnline;
//     data['is_vendor_online'] = isVendorOnline;
//     data['delivery_range'] = deliveryRange;
//     data['self_delivery'] = selfDelivery;
//     data['admin_commission'] = adminCommission;
//     data['as_driver_verified'] = asDriverVerified;
//     data['as_vendor_verified'] = asVendorVerified;
//     data['featured_store'] = featuredStore;
//     data['email_verified_at'] = emailVerifiedAt;
//     data['status'] = status;
//     data['is_profile_complete'] = isProfileComplete;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     return data;
//   }
// }
//
// class Address {
//   int? id;
//   int? userId;
//   String? latitude;
//   String? longitude;
//   String? location;
//   String? flatNo;
//   String? street;
//   String? landmark;
//   String? addressType;
//   String? createdAt;
//   String? updatedAt;
//   Null? deletedAt;
//
//   Address(
//       {this.id,
//         this.userId,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.flatNo,
//         this.street,
//         this.landmark,
//         this.addressType,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     flatNo = json['flat_no'];
//     street = json['street'];
//     landmark = json['landmark'];
//     addressType = json['address_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['location'] = location;
//     data['flat_no'] = flatNo;
//     data['street'] = street;
//     data['landmark'] = landmark;
//     data['address_type'] = addressType;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['deleted_at'] = deletedAt;
//     return data;
//   }
// }
//
// class OrderItems {
//   dynamic id;
//   dynamic productId;
//   String? productName;
//   dynamic variantId;
//   dynamic price;
//   String? itemQty;
//   dynamic qty;
//   dynamic totalPrice;
//
//   OrderItems(
//       {this.id,
//         this.productId,
//         this.productName,
//         this.variantId,
//         this.price,
//         this.itemQty,
//         this.qty,
//         this.totalPrice});
//
//   OrderItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     productName = json['product_name'];
//     variantId = json['variant_id'];
//     price = json['price'];
//     itemQty = json['item_qty'];
//     qty = json['qty'];
//     totalPrice = json['total_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['product_id'] = productId;
//     data['product_name'] = productName;
//     data['variant_id'] = variantId;
//     data['price'] = price;
//     data['item_qty'] = itemQty;
//     data['qty'] = qty;
//     data['total_price'] = totalPrice;
//     return data;
//   }
// }

class CheckOutDataModel {
  bool? status;
  String? message;
  Data? data;

  CheckOutDataModel({this.status, this.message, this.data});

  CheckOutDataModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic surcharge;
  dynamic tax;
  Tax1? tax1;
  Tax1? tax2;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  Map? couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  User? user;
  Vendor? vendor;
  Vendor? driver;
  Address? address;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic placedAt;

  Data(
      {this.orderId,
      this.itemTotal,
      this.surcharge,
      this.tax,
      this.tax1,
      this.tax2,
      this.deliveryCharges,
      this.packingFee,
      this.tipAmount,
      this.couponDiscount,
      this.commissionDriver,
      this.commissionAdmin,
      this.grandTotal,
      this.user,
      this.vendor,
      this.driver,
      this.address,
      this.orderType,
      this.deliveryStatus,
      this.orderItems,
      this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    surcharge = json['surcharge'];
    tax = json['tax'];
    tax1 = json['tax_1'] != null ? new Tax1.fromJson(json['tax_1']) : null;
    tax2 = json['tax_2'] != null ? new Tax1.fromJson(json['tax_2']) : null;
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    tipAmount = json['tip_amount'];
    couponDiscount = json['coupon_discount'];
    commissionDriver = json['commission_driver'];
    commissionAdmin = json['commission_admin'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    driver =
        json['driver'] != null ? new Vendor.fromJson(json['driver']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['surcharge'] = this.surcharge;
    data['tax'] = this.tax;
    if (this.tax1 != null) {
      data['tax_1'] = this.tax1!.toJson();
    }
    if (this.tax2 != null) {
      data['tax_2'] = this.tax2!.toJson();
    }
    data['delivery_charges'] = this.deliveryCharges;
    data['packing_fee'] = this.packingFee;
    data['tip_amount'] = this.tipAmount;
    data['coupon_discount'] = this.couponDiscount;
    data['commission_driver'] = this.commissionDriver;
    data['commission_admin'] = this.commissionAdmin;
    data['grand_total'] = this.grandTotal;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['delivery_status'] = this.deliveryStatus;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class Tax1 {
  dynamic type;
  dynamic amount;

  Tax1({this.type, this.amount});

  Tax1.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['amount'] = this.amount;
    return data;
  }
}

// class Tax2 {
//   dynamic type;
//   dynamic amount;
//
//   Tax2({this.type, this.amount});
//
//   Tax2.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     amount = json['amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['amount'] = this.amount;
//     return data;
//   }
// }

class User {
  dynamic id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic name;
  dynamic phone;
  dynamic email;
  dynamic otp;
  dynamic otpCreatedAt;
  dynamic otpVerified;
  dynamic profileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  User(
      {this.id,
      this.isDriver,
      this.isVendor,
      this.walletBalance,
      this.earnedBalance,
      this.name,
      this.phone,
      this.email,
      this.otp,
      this.otpCreatedAt,
      this.otpVerified,
      this.profileImage,
      this.latitude,
      this.longitude,
      this.location,
      this.defaultAddress,
      this.referalCode,
      this.deviceToken,
      this.deviceId,
      this.isDriverOnline,
      this.isVendorOnline,
      this.deliveryRange,
      this.selfDelivery,
      this.adminCommission,
      this.asDriverVerified,
      this.asVendorVerified,
      this.featuredStore,
      this.emailVerifiedAt,
      this.status,
      this.isProfileComplete,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_verified'] = this.otpVerified;
    data['profile_image'] = this.profileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Vendor {
  dynamic id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic name;
  dynamic phone;
  dynamic email;
  dynamic otp;
  dynamic otpCreatedAt;
  dynamic otpVerified;
  dynamic profileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Vendor(
      {this.id,
      this.isDriver,
      this.isVendor,
      this.walletBalance,
      this.earnedBalance,
      this.name,
      this.phone,
      this.email,
      this.otp,
      this.otpCreatedAt,
      this.otpVerified,
      this.profileImage,
      this.latitude,
      this.longitude,
      this.location,
      this.defaultAddress,
      this.referalCode,
      this.deviceToken,
      this.deviceId,
      this.isDriverOnline,
      this.isVendorOnline,
      this.deliveryRange,
      this.selfDelivery,
      this.adminCommission,
      this.asDriverVerified,
      this.asVendorVerified,
      this.featuredStore,
      this.emailVerifiedAt,
      this.status,
      this.isProfileComplete,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_verified'] = this.otpVerified;
    data['profile_image'] = this.profileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Address {
  int? id;
  int? userId;
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

class OrderItems {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic variantId;
  dynamic price;
  dynamic itemQty;
  dynamic qty;
  dynamic totalPrice;
  dynamic status;

  OrderItems(
      {this.id,
      this.productId,
      this.productName,
      this.variantId,
      this.price,
      this.itemQty,
      this.qty,
      this.totalPrice,
      this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    itemQty = json['item_qty'];
    qty = json['qty'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['variant_id'] = this.variantId;
    data['price'] = this.price;
    data['item_qty'] = this.itemQty;
    data['qty'] = this.qty;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
