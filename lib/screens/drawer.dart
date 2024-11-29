import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/admin_response_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/assigned_order.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_dashboard.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_delivery_details.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_information_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_registration.dart';
import 'package:fresh2_arrive/screens/help_center.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:fresh2_arrive/screens/myProfile.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/screens/order/myorder_screen.dart';
import 'package:fresh2_arrive/screens/privacy_policy.dart';
import 'package:fresh2_arrive/screens/refer_and_earn.dart';
import 'package:fresh2_arrive/screens/terms_conditions.dart';
import 'package:fresh2_arrive/screens/vendor_screen/bank_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/marketingmanager.dart';
import 'package:fresh2_arrive/screens/vendor_screen/reffer_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/store_open_time_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_information_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_products.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_registration.dart';
import 'package:fresh2_arrive/screens/vendor_screen/withdraw_money.dart';
import 'package:fresh2_arrive/screens/wallet_screen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../repositories/user_profile_repository.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'customer_support.dart';
import 'driver_screen/withdraw_moeny.dart';

class CustomDrawer extends StatefulWidget {
  // final void Function(int index) onItemTapped;

  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
  final myOrderController = Get.put(MyOrderController());
  final RxBool _isValue = false.obs;
  final RxBool _isValue1 = false.obs;
  final RxBool _isValue2 = false.obs;
  var vendor = [
    'Dashboard',
    'Order',
    'Products',
    'Store open time',
    'Vendor Information',
    'Bank Details',
    'Withdraw'
  ];
  var vendorRoutes = [
    VenderDashboard.vendorDashboard,
    VendorOrderList.vendorOrderList,
    VendorProductScreen.vendorProductScreen,
    SetTimeScreen.setTimeScreen,
    VendorInformation.vendorInformation,
    BankDetailsScreen.bankDetailsScreen,
    WithDrawMoney.withDrawMoney,
  ];

  var driver = [
    'Dashboard',
    'Assigned Order',
    'Bank Details',
    'Withdraw',
    'Delivery Partner Information',
  ];
  var driverRoutes = [
    DeliveryDashboard.deliveryDashboard,
    AssignedOrder.assignedOrder,
    BankDetailsScreen.bankDetailsScreen,
    DriverWithdrawMoney.driverWithdrawMoney,
    DriverInformation.driverInformation,
  ];

  var marketingManager = [
    'Marketing Partner',
    'Withdraw',
  ];
  var marketingManagerRoutes = [
    RefferScreen.refferscreen,
    WithDrawMoney.withDrawMoney,
  ];


  ClientInformation? _clientInfo;

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', _clientInfo!.deviceId.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Drawer(
      child: Obx(() {
        return
          Container(
          color: AppTheme.backgroundcolor,
          // height: SizeConfig.heightMultiplier * 100,
          // width: SizeConfig.widthMultiplier! * 80,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: screenSize.height * 0.30,
                  width: screenSize.width,
                  color: AppTheme.primaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(navigationPage.elementAt(_currentPage))
                          // Get.to(MyProfile());
                        },
                        child: Card(
                            elevation: 3,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                                margin: const EdgeInsets.all(4),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      profileController.isDataLoading.value
                                          ? (profileController.model.value.data!
                                          .user!.profileImage ??
                                                  "")
                                              .toString()
                                          : "",
                                  height: screenSize.height * 0.12,
                                  width: screenSize.height * 0.12,
                                  errorWidget: (_, __, ___) => const Icon(Icons.person,size: 50,),
                                  placeholder: (_, __) => const SizedBox(),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Text(
                          profileController.isDataLoading.value
                              ? (profileController.model.value.data!.user!.name ?? "")
                                  .toString()
                              : "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Text(
                          profileController.isDataLoading.value
                              ? (profileController.model.value.data!.user!.email ??
                                      "")
                                  .toString()
                              : "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(
                          // height: SizeConfig.heightMultiplier! * 1.8,
                          ),
                    ],
                  ),
                ),
                const SizedBox(
                    // height: SizeConfig.heightMultiplier! * .5,
                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _drawerTile(
                          active: true,
                          title: "My Orders",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_order),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            myOrderController.getMyOrder();
                            Get.back();
                            controller.onItemTap(4);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Profile",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_profile),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(MyProfileScreen.myProfileScreen);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Notification",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_notification),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            Get.toNamed(NotificationScreen.notificationScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Address",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_location),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () {
                            Get.toNamed(MyAddress.myAddressScreen);
                            // Get.back();
                            // widget.onItemTapped(1);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Refer and Earn",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_refer),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(ReferAndEarn.referAndEarnScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "My Wallet",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_wallet),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(WalletScreen.myWalletScreen);
                          }),
                      const Divider(
                        height: 1,
                      ),
                      profileController.isDataLoading.value
                          ? profileController.model.value.data!.user!.isVendor ==
                                  false
                              ? _drawerTile(
                                  active: true,
                                  title: "Sign in as a vendor",
                                  icon: const ImageIcon(
                                    AssetImage(AppAssets.drawer_vendor),
                                    size: 22,
                                    color: AppTheme.primaryColor,
                                  ),
                                  onTap: () async {
                                    Get.toNamed(
                                      VendorRegistrationForm
                                          .vendorRegistrationForm,
                                    );
                                    // }
                                  })
                              : profileController
                                          .model.value.data!.user!.asVendorVerified ==
                                      true
                                  ? Column(
                                      children: [
                                        const Divider(
                                          height: 1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _isValue.value = !_isValue.value;
                                          },
                                          child: ListTile(
                                            minLeadingWidth: 30,
                                            leading: const ImageIcon(
                                              AssetImage(
                                                  AppAssets.drawer_vendor),
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            ),
                                            textColor: AppTheme.primaryColor,
                                            iconColor: AppTheme.blackcolor,
                                            title: const Text(
                                              'Vendor',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.primaryColor),
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  _isValue.value =
                                                      !_isValue.value;
                                                },
                                                child: Icon(_isValue.value ==
                                                        true
                                                    ? Icons
                                                        .keyboard_arrow_up_rounded
                                                    : Icons
                                                        .keyboard_arrow_down_outlined)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _drawerTile(
                                      active: true,
                                      title: "Vendor",
                                      icon: const ImageIcon(
                                        AssetImage(AppAssets.drawer_vendor),
                                        size: 22,
                                        color: AppTheme.primaryColor,
                                      ),
                                      onTap: () async {
                                        Get.toNamed(AdminResponseScreen
                                            .adminResponseScreen);
                                      })
                          : const SizedBox(),
                      _isValue.value == true
                          ? Column(
                              children: List.generate(
                                  vendor.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          index == 6?
                                          Get.toNamed(vendorRoutes[index],arguments: 0):
                                          Get.toNamed(vendorRoutes[index]);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AddSize.size5),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 65,
                                              ),
                                              Text(
                                                vendor[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            )
                          : const SizedBox(),
                      const Divider(
                        height: 1,
                      ),
                      profileController.isDataLoading.value
                          ? profileController.model.value.data!.user!.isDriver ==
                                  false
                              ? _drawerTile(
                                  active: true,
                                  title: "Sign in as a delivery partner",
                                  icon: const ImageIcon(
                                    AssetImage(AppAssets.drawer_driver),
                                    size: 22,
                                    color: AppTheme.primaryColor,
                                  ),
                                  onTap: () async {
                                    Get.toNamed(DriverRegistrationScreen
                                        .driverRegistrationScreen);
                                  })
                              : profileController
                                          .model.value.data!.user!.asDriverVerified ==
                                      true
                                  ? Column(
                                      children: [
                                        const Divider(
                                          height: 1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _isValue1.value = !_isValue1.value;
                                          },
                                          child: ListTile(
                                            minLeadingWidth: 30,
                                            leading: const ImageIcon(
                                              AssetImage(
                                                  AppAssets.drawer_driver),
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            ),
                                            textColor: AppTheme.primaryColor,
                                            iconColor: AppTheme.blackcolor,
                                            title: const Text(
                                              'Delivery Partner',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppTheme.primaryColor),
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  _isValue1.value =
                                                      !_isValue1.value;
                                                },
                                                child: Icon(_isValue1
                                                            .value ==
                                                        true
                                                    ? Icons
                                                        .keyboard_arrow_up_rounded
                                                    : Icons
                                                        .keyboard_arrow_down_outlined)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _drawerTile(
                                      active: true,
                                      title: "Delivery Partner",
                                      icon: const ImageIcon(
                                        AssetImage(AppAssets.drawer_driver),
                                        size: 22,
                                        color: AppTheme.primaryColor,
                                      ),
                                      onTap: () async {
                                        Get.toNamed(AdminResponseScreen
                                            .adminResponseScreen);
                                      })
                          : const SizedBox(),
                      _isValue1.value == true
                          ? Column(
                              children: List.generate(
                                  driver.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          index == 3?
                                          Get.toNamed(driverRoutes[index],arguments: 0):
                                          Get.toNamed(driverRoutes[index]);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AddSize.size5),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 65,
                                              ),
                                              Text(
                                                driver[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade500),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            )
                          : const SizedBox(),
                      const Divider(
                        height: 1,
                      ),
                      // profileController.model.value.data!.isMarketingManager ==
                      //         true
                      //     ? _drawerTile(
                      //         active: true,
                      //         title: "Marketing Partner",
                      //         icon: const ImageIcon(
                      //           AssetImage(AppAssets.market),
                      //           size: 22,
                      //           color: AppTheme.primaryColor,
                      //         ),
                      //         onTap: () {
                      //           Get.toNamed(RefferScreen.refferscreen);
                      //           // }
                      //         })
                      //     : profileController.model.value.data!
                      //                 .asMarketingManagerVerified ==
                      //             false
                      //         ? _drawerTile(
                      //             active: true,
                      //             title: "Marketing Manager",
                      //             icon: const ImageIcon(
                      //               AssetImage(AppAssets.market),
                      //               size: 22,
                      //               color: AppTheme.primaryColor,
                      //             ),
                      //             onTap: () {
                      //               Get.toNamed(
                      //                   MarketingManager.marketingmanager);
                      //             })
                      //         : SizedBox(),
                      //
                      // const Divider(
                      //   height: 1,
                      // ),

                      profileController.isDataLoading.value
                          ? profileController.model.value.data!.user!.isMarketingManager ==
                          false
                          ? _drawerTile(
                          active: true,
                          title: "Sign in as Marketing Partner",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.market),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(
                                MarketingManager.marketingmanager);
                          })
                          : profileController
                          .model.value.data!.user!.asMarketingManagerVerified ==
                          true
                          ? Column(
                        children: [
                          const Divider(
                            height: 1,
                          ),
                          GestureDetector(
                            onTap: () {
                              _isValue2.value = !_isValue2.value;
                            },
                            child: ListTile(
                              minLeadingWidth: 30,
                              leading: const ImageIcon(
                                AssetImage(AppAssets.market),
                                size: 22,
                                color: AppTheme.primaryColor,
                              ),
                              textColor: AppTheme.primaryColor,
                              iconColor: AppTheme.blackcolor,
                              title: const Text(
                                'Marketing Partner',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.primaryColor),
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    _isValue2.value = !_isValue2.value;
                                  },
                                  child: Icon(_isValue2
                                      .value ==
                                      true
                                      ? Icons
                                      .keyboard_arrow_up_rounded
                                      : Icons
                                      .keyboard_arrow_down_outlined)),
                            ),
                          ),
                        ],
                      )
                          : _drawerTile(
                          active: true,
                          title: "Marketing Partner",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.market),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(AdminResponseScreen
                                .adminResponseScreen);
                          })
                          : const SizedBox(),
                      _isValue2.value == true
                          ? Column(
                        children: List.generate(
                            marketingManager.length,
                                (index) => GestureDetector(
                              onTap: () {
                                index == 1?
                                Get.toNamed(marketingManagerRoutes[index],arguments: 1):
                                Get.toNamed(marketingManagerRoutes[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AddSize.size5),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 65,
                                    ),
                                    Text(
                                      marketingManager[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                          Colors.grey.shade500),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      )
                          : const SizedBox(),
                      const Divider(
                        height: 1,
                      ),

                      _drawerTile(
                          active: true,
                          title: "Term & Condition",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_term_condition),
                            size: 26,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(TermsAndConditions.termAndConditionScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Privacy Policy",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_privacy),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(PrivacyPolicy.privacyPolicyScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Customer Support",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_support),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(CustomerSupport.customerSupportScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Help Center",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_help),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            Get.toNamed(HelpCenter.helpCenterScreen);
                            // }
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Delete User",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_logout),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            showDialog1();
                          }),
                      const Divider(
                        height: 1,
                      ),
                      _drawerTile(
                          active: true,
                          title: "Logout",
                          icon: const ImageIcon(
                            AssetImage(AppAssets.drawer_logout),
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          onTap: () async {
                            _getClientInformation();
                            Get.back();
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Get.offAllNamed(LoginScreen.loginScreen);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  showDialog1() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            child: Image.asset(
                              'assets/images/cross_img.png',
                              height: 90,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      'Would You Like To Delete This Address?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFFA302), Color(0xFFFF5102)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  deleteUser(context).then((value) {
                                    showToast(value.message.toString());
                                    if (value.status == true) {
                                      showToast(value.message.toString());
                                      Get.to(const LoginScreen());
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    minimumSize: Size(80, 40)),
                                child: Text('Yes, Delete This Address',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                          ),
                        ),
                        SizedBox(
                          width: width * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFF0433F))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Center(
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFF5102)))),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _drawerTile(
      {required bool active,
      required String title,
      required ImageIcon icon,
      required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: AppTheme.primaryColor,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
