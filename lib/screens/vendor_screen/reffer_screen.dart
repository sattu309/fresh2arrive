import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import '../../model/marketinginf_model.dart';
import '../../repositories/marketinginf_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_error.dart';
import '../../widgets/dimensions.dart';
import '../marketing_manager_order_details_screen.dart';
import '../see_all_refferal_list.dart';

class RefferScreen extends StatefulWidget {
  static var refferscreen = "/refferscreen";

  const RefferScreen({Key? key}) : super(key: key);

  @override
  State<RefferScreen> createState() => _RefferScreenState();
}

class _RefferScreenState extends State<RefferScreen> {
  TextEditingController message = TextEditingController();
  RxString image = "".obs;
  Rx<RxStatus> statusOfManagerInf = RxStatus.empty().obs;
  Rx<MarketingInfModel> managerinf = MarketingInfModel().obs;
  String? referralLink;


  getDataSubscription() {
    ManagerInfRepo().then((value) async {
      managerinf.value = value;
      if (value.status == true) {
        log(value.data!.referralCode.toString());
        generateLink(
            BranchUniversalObject(
                canonicalIdentifier: 'flutter/branch',
                canonicalUrl: '',
                title: '',
                contentDescription: '',
                contentMetadata: BranchContentMetaData()
                  ..addCustomMetadata('referralCode', value.data!.referralCode.toString()),
                keywords: ['Plugin', 'Branch', 'Flutter'],
                publiclyIndex: true,
                locallyIndex: true,
                expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch),
            BranchLinkProperties(
                channel: 'facebook',
                feature: 'sharing',
                stage: 'new share',
                campaign: 'campaign',
                tags: ['one', 'two', 'three']));
        // Get.toNamed(ThankuScreen.thanku);
        print("1111111111111");
        statusOfManagerInf.value = RxStatus.success();
        setState(() {});
      } else {
        statusOfManagerInf.value = RxStatus.error();
      }
    });
  }

  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();
  StreamController<String> controllerUrl = StreamController<String>();

  void initDeepLinkData() {
    ManagerInfRepo().then((value) async {
      managerinf.value = value;
      if (value.status == true) {
        log(value.data!.referralCode.toString());
        metadata = BranchContentMetaData()
          ..addCustomMetadata('referralCode', value.data!.referralCode.toString())
          //--optional Custom Metadata
          ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
          ..price = 50.99
          ..currencyType = BranchCurrencyType.BRL
          ..quantity = 50
          ..sku = 'sku'
          ..productName = 'productName'
          ..productBrand = 'productBrand'
          ..productCategory = BranchProductCategory.ELECTRONICS
          ..productVariant = 'productVariant'
          ..condition = BranchCondition.NEW
          ..rating = 100
          ..ratingAverage = 50
          ..ratingMax = 100
          ..ratingCount = 2
          ..setAddress(street: 'street', city: 'city', region: 'ES', country: 'Brazil', postalCode: '99999-987')
          ..setLocation(31.4521685, -114.7352207);

        buo = BranchUniversalObject(
            canonicalIdentifier: 'flutter/branch',
            canonicalUrl: '',
            title: '',
            contentDescription: '',
            contentMetadata: metadata,
            keywords: ['Plugin', 'Branch', 'Flutter'],
            publiclyIndex: true,
            locallyIndex: true,
            expirationDateInMilliSec: DateTime.now().add(const Duration(days: 365)).millisecondsSinceEpoch);

        lp = BranchLinkProperties(
            channel: 'facebook',
            feature: 'sharing',
            stage: 'new share',
            campaign: 'campaign',
            tags: ['one', 'two', 'three'])
          ..addControlParam('\$uri_redirect_mode', '1');
      }
    });
  }

  void generateLink(BranchUniversalObject? buo, BranchLinkProperties lp) async {
    BranchResponse response = await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      controllerUrl.sink.add('${response.result}');
      referralLink = response.result;
      setState(() {});
      print("referralLink $referralLink");
    } else {
      controllerUrl.sink.add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSubscription();
    initDeepLinkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leadingWidth: AddSize.size20 * 1.6,
          backgroundColor: Colors.white,
          title: Text(
            'Marketing Partner',
            style: TextStyle(
              color: Color(0xff423E5E),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: AddSize.padding10),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.back,
                  height: AddSize.size20,
                )),
          ),
        ),
        body: Obx(() {
          return statusOfManagerInf.value.isSuccess
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding18),
                      child: Column(children: [
                        Card(
                            elevation: 0,
                            color: AppTheme.backgroundcolor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: AddSize.padding18, vertical: AddSize.padding20),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(
                                    "Refer Link",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font16),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          /*managerinf
                                                  .value.data!.referralLink
                                                  .toString()*/
                                          referralLink ?? "".toString(),
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      InkWell(
                                        child: Image(
                                            height: 18,
                                            width: 18,
                                            image: AssetImage(
                                              AppAssets.shareIcon,
                                            )),
                                        onTap: () {
                                          Share.share(
                                              "Fresh2Arrive: Never Out of Stock-NOOS\n\nFresh2Arrive is an app that provided fresh vegetables, Fruits, Restaurant foods, Grocery Items & Many more Through its Registered Vendor & Delivery Partners@24 Hours & @7 Days a week.\n\nUse my referral code ${managerinf.value.data!.referralCode.toString()} while signing up.\n\n" +
                                                  referralLink!);
                                          // Clipboard.setData(
                                          //     new ClipboardData(
                                          //         text: referralLink.toString()));
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //   backgroundColor:
                                          //       AppTheme.primaryColor,
                                          //   content:
                                          //       Text("Copied to Clipboard"),
                                          // ));
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ]))),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Card(
                                    elevation: 0,
                                    color: AppTheme.backgroundcolor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding18, vertical: AddSize.padding20),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Row(children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text(
                                                "My Earnings",
                                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                    color: AppTheme.primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font16),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "₹" + managerinf.value.data!.earning.toString(),
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ])
                                          ])
                                        ]))),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Card(
                                    elevation: 0,
                                    color: AppTheme.backgroundcolor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding18, vertical: AddSize.padding20),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Row(children: [
                                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text(
                                                "Total Orders",
                                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                    color: AppTheme.primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AddSize.font16),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                managerinf.value.data!.totalOrders.toString(),
                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                              ),
                                            ])
                                          ]),
                                        ]))),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding18, vertical: AddSize.padding10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order List",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Color(0xff212E3E), fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(ReferralOrderList.referralOrderList);
                                },
                                child: Text(
                                  "See all",
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AddSize.font16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        managerinf.value.data!.orderList!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: managerinf.value.data!.orderList!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = managerinf.value.data!.orderList![index];
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(MarketingOrderDetails.marketingOrderDetails, arguments: [item]);
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: AppTheme.backgroundcolor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AddSize.padding18, vertical: AddSize.padding20),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppAssets.orderList,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        item.date,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "Order ID: #${item.orderId}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500, color: AppTheme.primaryColor),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "Earning",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 45,
                                        right: 20,
                                        child: Text(
                                          "₹" + item.orderAmount.toString(),
                                          style:
                                              TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16),
                                        ),
                                      ),
                                      Positioned(
                                        top: 70,
                                        right: 20,
                                        child: Text(
                                          "₹" + item.commissionMarketingPartner.toString(),
                                          style:
                                              TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: AddSize.padding20 * 3),
                                child: Text("Order not Available",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AddSize.font14,
                                        color: AppTheme.blackcolor)),
                              ),
                      ])))
              : statusOfManagerInf.value.isError
                  ? CommonErrorWidget(
                      errorText: managerinf.value.message.toString(),
                      onTap: () {},
                    )
                  : Center(child: const CircularProgressIndicator());
        }));
  }
}
