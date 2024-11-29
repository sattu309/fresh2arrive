import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/marketinginf_model.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';

class MarketingOrderDetails extends StatefulWidget {
  const MarketingOrderDetails({Key? key}) : super(key: key);
  static var marketingOrderDetails = "/marketingOrderDetails";
  @override
  State<MarketingOrderDetails> createState() => _MarketingOrderDetailsState();
}

class _MarketingOrderDetailsState extends State<MarketingOrderDetails> {
  Rx<MerketingOrderList> merketingOrderList = MerketingOrderList().obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    if (Get.arguments != null) {
      merketingOrderList.value = Get.arguments[0];
    }
  }

  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(title: "Details", context: context),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  color: AppTheme.backgroundcolor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AddSize.padding18, vertical: AddSize.padding20),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppAssets.orderList,
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 10),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID: #" + merketingOrderList.value.orderId.toString(),
                                      style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.primaryColor),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${merketingOrderList.value.date.toString()}",
                                      style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 12),
                                    ),
                                  ]),
                            ]),
                        Divider(),
                        Column(
                          children: [
                            ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Name",
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: AppTheme.lightblack,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font14),
                                        ),
                                        Text(
                                          (merketingOrderList.value.name ?? "").toString(),
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              height: 1.5, fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Container(
                                    height: AddSize.size45,
                                    width: AddSize.size45,
                                    decoration: const ShapeDecoration(color: Colors.orange, shape: CircleBorder()),
                                    child: const Center(
                                        child: Icon(
                                      Icons.person_rounded,
                                      color: AppTheme.backgroundcolor,
                                    )),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Number",
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: AppTheme.lightblack,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font14),
                                        ),
                                        Text(
                                          (merketingOrderList.value.phone ?? "").toString(),
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              height: 1.5, fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                  GestureDetector(
                                    onTap: () async {
                                      var url = "https://wa.me/+91 ${merketingOrderList.value.phone ?? ""}/?text=Hello";
                                      if (await launch(url)) {
                                        await canLaunch(url);
                                      } else {
                                        showToast('there is no WhatsApp installed');
                                      }
                                    },
                                    child: Container(
                                        height: AddSize.size50,
                                        width: AddSize.size50,
                                        decoration: const ShapeDecoration(
                                            color: AppTheme.backgroundcolor, shape: CircleBorder()),
                                        child: Center(
                                            child: Image.asset(
                                          AppAssets.whatsappIcon,
                                        ))),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "User Location",
                                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  color: AppTheme.lightblack,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.font14),
                                            ),
                                            Text(
                                              (merketingOrderList.value.address!.location ?? "").toString(),
                                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  height: 1.5, fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Container(
                                    height: AddSize.size45,
                                    width: AddSize.size45,
                                    decoration:
                                        const ShapeDecoration(color: AppTheme.lightYellow, shape: CircleBorder()),
                                    child: const Center(
                                        child: Icon(
                                      Icons.location_on,
                                      color: AppTheme.backgroundcolor,
                                    )),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Divider(),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Amount",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: AppTheme.lightblack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AddSize.font14),
                                  ),
                                  Text(
                                    "₹" + (merketingOrderList.value.orderAmount ?? "").toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(height: 1.5, fontWeight: FontWeight.w600, fontSize: AddSize.font14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Divider(),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Earning",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: AppTheme.lightblack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AddSize.font14),
                                  ),
                                  Text(
                                    "₹" + (merketingOrderList.value.commissionMarketingPartner ?? "").toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(height: 1.5, fontWeight: FontWeight.w600, fontSize: AddSize.font14),
                                  ),
                                ],
                              )
                              // const Divider(),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       child: Row(children: [
                              //         Expanded(
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment
                              //                     .start,
                              //             children: [
                              //               Text(
                              //                 "Delivery Address",
                              //                 style: Theme.of(
                              //                         context)
                              //                     .textTheme
                              //                     .headlineSmall!
                              //                     .copyWith(
                              //                         color: AppTheme
                              //                             .lightblack,
                              //                         fontWeight:
                              //                             FontWeight
                              //                                 .w400,
                              //                         fontSize: AddSize
                              //                             .font14),
                              //               ),
                              //               Row(
                              //                 children: [
                              //                   Expanded(
                              //                     child: Text(
                              //                       (myOrderDetailsController
                              //                                   .model
                              //                                   .value
                              //                                   .data!
                              //                                   .driver!
                              //                                   .location ??
                              //                               "")
                              //                           .toString(),
                              //                       maxLines: 2,
                              //                       style: Theme.of(
                              //                               context)
                              //                           .textTheme
                              //                           .headlineSmall!
                              //                           .copyWith(
                              //                               height:
                              //                                   1.5,
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .w500,
                              //                               overflow:
                              //                                   TextOverflow
                              //                                       .ellipsis,
                              //                               fontSize:
                              //                                   AddSize.font16),
                              //                     ),
                              //                   ),
                              //                   const SizedBox(
                              //                     width: 5,
                              //                   ),
                              //                 ],
                              //               ),
                              //               const SizedBox(
                              //                 width: 5,
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ]),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         openMap(
                              //             double.parse(
                              //                 myOrderDetailsController
                              //                     .model
                              //                     .value
                              //                     .data!
                              //                     .driver!
                              //                     .latitude
                              //                     .toString()),
                              //             double.parse(
                              //                 myOrderDetailsController
                              //                     .model
                              //                     .value
                              //                     .data!
                              //                     .driver!
                              //                     .longitude
                              //                     .toString()));
                              //       },
                              //       child: Container(
                              //         height: AddSize.size45,
                              //         width: AddSize.size45,
                              //         decoration:
                              //             const ShapeDecoration(
                              //                 color: AppTheme
                              //                     .lightYellow,
                              //                 shape:
                              //                     CircleBorder()),
                              //         child: const Center(
                              //             child: Icon(
                              //           Icons.location_on,
                              //           color: AppTheme
                              //               .backgroundcolor,
                              //         )),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
