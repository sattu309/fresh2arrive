import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/payment_option_controller.dart';
import 'package:fresh2_arrive/repositories/payment_order_repo.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../controller/My_cart_controller.dart';
import '../repositories/check_out_repository.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  static var paymentScreen = "/paymentScreen";

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final controller = Get.put(PaymentOptionController());
  final myCartController = Get.put(MyCartDataListController());
  bool _isValue = false;
  RxString selectedValue = "".obs;
  RxString orderId = "".obs;
  final Razorpay _razorpay = Razorpay();

  void processPayment() {
    var options = {
      'key': 'rzp_live_1HJot1eILYIf7B',
      'amount': _isValue == true && selectedValue.value == "online"
          ? ((Get.arguments[0] - controller.model.value.data!.earnedBalance) * 100)
          : (Get.arguments[0] * 100),
      'name': 'Fresh2Arrive',
      'description': 'Payment',
      'prefill': {'contact': '9990194488', 'email': 'fresh2arrive@gmail.com'}
    };
    _razorpay.open(options);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentOrder(
            context: context,
            // order_id: orderId.value,
            payment_id: response.paymentId,
            razorpay_signature: "Signature",
            wallet_deduction: controller.model.value.data!.earnedBalance,
            online_deduction: Get.arguments[0] - controller.model.value.data!.earnedBalance)
        .then((value) {
      showToast(value.message).toString();
      if (value.status == true) {
        myCartController.getAddToCartList();
        Get.offAllNamed(ThankYouScreen.thankYouScreen,
            arguments: [
              value.data!.orderType,
              value.data!.orderId,
              value.data!.placedAt,
              value.data!.itemTotal,
              value.data!.tax !=0 ? value.data!.tax:"",
              value.data!.deliveryCharges,
              value.data!.packingFee,
              value.data!.grandTotal,
              value.data!.orderId,
              value.data!.tax1 != null ? value.data?.tax1!.type:"",
              value.data!.tax1 != null ? value.data?.tax1!.amount:"",
              value.data!.tax2 != null ? value.data?.tax2!.type:"",
              value.data!.tax2 != null ? value.data?.tax2!.amount:"",
              value.data!.surcharge,
              value.data!.tipAmount,
              value.data!.couponDiscount == null ? "" : value.data!.couponDiscount!['discounted_price']
            ]);
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log(response.message.toString());
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log(response.walletName.toString());
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar(title: "Select Payment Method", context: context),
      body: Obx(() {
        if (controller.isDataLoading.value &&
            controller.model.value.data != null) {
          // if (controller.model.value.data!.earnedBalance >= Get.arguments[0]) {
          //   _isValue = true;
          //   print("AAAAAAAAAAAAAA-----${_isValue}");
          // }
        }
        return controller.isDataLoading.value
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Image(
                                    image: const AssetImage(
                                        AppAssets.paymentIcon1),
                                    height: height * .03,
                                    width: width * .10,
                                  ),
                                  SizedBox(
                                    width: width * .04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "My Wallet balance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.blackcolor,
                                                fontSize: 14),
                                      ),
                                      Text(
                                        "₹${controller.model.value.data!.earnedBalance}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                height: 1.5,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ]),
                                Checkbox(
                                    side: const BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    value: _isValue,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isValue = value!;
                                        log(_isValue.toString());
                                        if (_isValue == true) {
                                          selectedValue.value = "";
                                        }
                                        // else {
                                        //   selectedValue.value = "cod";
                                        // }
                                      });
                                    })
                              ],
                            ),
                          )),
                      // controller.model.value.data!.earnedBalance <=
                      //         Get.arguments[0]
                      //     ?
                      Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectedValue.value = "online";
                                    if (kDebugMode) {
                                      print(selectedValue.value);
                                    }
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Image(
                                                image: const AssetImage(
                                                    AppAssets.mastercardIcon),
                                                height: height * .04,
                                                width: width * .10,
                                              ),
                                              SizedBox(
                                                width: width * .04,
                                              ),
                                              Text(
                                                "Online Payment",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppTheme.blackcolor,
                                                        fontSize: 16),
                                              ),
                                            ]),
                                            Obx(() {
                                              return Radio<String>(
                                                value: "online",
                                                groupValue: selectedValue.value,
                                                onChanged: (value) {
                                                  selectedValue.value = value!;
                                                  print(selectedValue.value);
                                                },
                                              );
                                            }),
                                          ],
                                        ),
                                      )),
                                ),
                                controller.model.value.data!.cod == true
                                    ? GestureDetector(
                                        onTap: () {
                                          selectedValue.value = "cod";
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(children: [
                                                    Image(
                                                      image: const AssetImage(
                                                          AppAssets.cashIcon),
                                                      height: height * .03,
                                                      width: width * .08,
                                                    ),
                                                    SizedBox(
                                                      width: width * .04,
                                                    ),
                                                    Text(
                                                      "Cash on delivery",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              height: 1.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontSize: 16),
                                                    ),
                                                  ]),
                                                  Obx(() {
                                                    return Radio<String>(
                                                      value: "cod",
                                                      groupValue:
                                                          selectedValue.value,
                                                      onChanged: (value) {
                                                        selectedValue.value = value!;
                                                          print(selectedValue.value);
                                                        // if (_isValue == false) {
                                                        //   selectedValue.value = value!;
                                                        //   print(selectedValue
                                                        //       .value);
                                                        // }
                                                      },
                                                    );
                                                  }),
                                                ],
                                              ),
                                            )),
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          // : SizedBox(),
                    ],
                  ),
                ))
            : Center(
                child: Padding(
                  padding: EdgeInsets.only(top: AddSize.padding20),
                  child: const CircularProgressIndicator(),
                ),
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Orders Cannot be cancelled once packed for delivery.",style: TextStyle(fontSize: AddSize.font14,fontWeight: FontWeight.w500),),
            Text("Check your order Qty & Quality as per your Bill, before provide OTP Number to Delivery Partner.",style: TextStyle(fontSize: AddSize.font14,fontWeight: FontWeight.w500)),
            Text("After Accepting Order with Your OTP. No Refund/Return & Cancelled the orders.",style: TextStyle(fontSize: AddSize.font14,fontWeight: FontWeight.w500)),
            Text("In Case of Unexpected Orders Issue, a refund will be provided, if applicable",style: TextStyle(fontSize: AddSize.font14,fontWeight: FontWeight.w500)),
            SizedBox(
              height: AddSize.padding20,
            ),
            ElevatedButton(
                onPressed: () {
                  if(selectedValue.value == "" && _isValue == false)
                 {
                   showToast("Pleas select payment method");
                 }
                  else{
                    if (_isValue == true) {
                      if (controller.model.value.data!.earnedBalance >= Get.arguments[0]) {
                        checkOut(payment_type: "online", context: context)
                            .then((value) async {
                          if (value.status == true) {
                            myCartController.getAddToCartList();
                            print(value.data!.orderId);
                            print("aaaaaaaa");
                            await paymentOrder(
                                context: context,
                                // order_id: value.data!.orderId,
                                payment_id: "",
                                razorpay_signature: "",
                                wallet_deduction: Get.arguments[0],
                                online_deduction: "")
                                .then((value) {
                              showToast(value.message).toString();
                              if (value.status == true) {
                                myCartController.getAddToCartList();
                                // dynamic discount= value.data!.couponDiscount!['discounted_price'] ?? "";
                                Get.offAllNamed(ThankYouScreen.thankYouScreen,
                                    arguments: [
                                      value.data!.orderType,
                                      value.data!.orderId,
                                      value.data!.placedAt,
                                      value.data!.itemTotal,
                                      value.data!.tax !=0 ? value.data!.tax:"",
                                      value.data!.deliveryCharges,
                                      value.data!.packingFee,
                                      value.data!.grandTotal,
                                      value.data!.orderId,
                                      value.data!.tax1 != null ? value.data?.tax1!.type:"",
                                      value.data!.tax1 != null ? value.data?.tax1!.amount:"",
                                      value.data!.tax2 != null ? value.data?.tax2!.type:"",
                                      value.data!.tax2 != null ? value.data?.tax2!.amount:"",
                                      value.data!.surcharge,
                                      value.data!.tipAmount,
                                      value.data!.couponDiscount == null ? "" : value.data!.couponDiscount!['discounted_price']

                                    ]);
                              }
                            });
                          }
                        });
                      } else {
                        checkOut(payment_type: "online", context: context)
                            .then((value) {
                          if (value.status == true) {
                            orderId.value = value.data!.orderId.toString();
                            print(orderId.value);
                            myCartController.getAddToCartList();
                            processPayment();
                          }
                        });
                      }
                    }
                    else if (selectedValue.value == "cod") {
                      checkOut(
                          payment_type: selectedValue.value, context: context)
                          .then((value) {
                        myCartController.getAddToCartList();
                        if (value.status == true) {
                          // dynamic discount= value.data!.couponDiscount == null ? "" : value.data!.couponDiscount!['discounted_price'];
                          //  print("Coupon argument..${discount}");
                          Get.offAllNamed(ThankYouScreen.thankYouScreen,
                              arguments: [
                                value.data!.orderType,
                                value.data!.orderId,
                                value.data!.placedAt,
                                value.data!.itemTotal,
                                value.data!.tax !=0 ? value.data!.tax:"",
                                value.data!.deliveryCharges,
                                value.data!.packingFee,
                                value.data!.grandTotal,
                                value.data!.orderId,
                                value.data!.tax1 != null ? value.data?.tax1!.type:"",
                                value.data!.tax1 != null ? value.data?.tax1!.amount:"",
                                value.data!.tax2 != null ? value.data?.tax2!.type:"",
                                value.data!.tax2 != null ? value.data?.tax2!.amount:"",
                                value.data!.surcharge,
                                value.data!.tipAmount,
                                value.data!.couponDiscount == null ? "" : value.data!.couponDiscount!['discounted_price']
                              ]);
                        }
                      });
                    }
                    else if(_isValue == true && selectedValue.value == "online"){
                      checkOut(payment_type: "online", context: context)
                          .then((value) async {
                        if (value.status == true) {
                          myCartController.getAddToCartList();
                          print(value.data!.orderId);
                          print("aaaaaaaa");
                          await paymentOrder(
                              context: context,
                              // order_id: value.data!.orderId,
                              payment_id: "",
                              razorpay_signature: "",
                              wallet_deduction: Get.arguments[0],
                              online_deduction: "")
                              .then((value) {
                            processPayment();
                            myCartController.getAddToCartList();
                          });
                        }
                      });
                    }
                    else {
                      checkOut(payment_type: "online", context: context)
                          .then((value) {
                        if (value.status == true) {
                          orderId.value = value.data!.orderId.toString();
                          print(orderId.value);
                          myCartController.getAddToCartList();
                          processPayment();
                          myCartController.getAddToCartList();
                        }
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    backgroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                child: Text(
                  "Checkout",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
            SizedBox(
              height: AddSize.padding20,
            ),
            // selectedValue.value != "cod"
            //     ? ElevatedButton(
            //         onPressed: () {
            //           processPayment();
            //         },
            //         style: ElevatedButton.styleFrom(
            //             minimumSize: const Size(double.maxFinite, 60),
            //             backgroundColor: AppTheme.primaryColor,
            //             elevation: 0,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             textStyle: const TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.w600)),
            //         child: Text(
            //           "Checkout",
            //           style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //               color: AppTheme.backgroundcolor,
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16),
            //         ))
            //     : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
