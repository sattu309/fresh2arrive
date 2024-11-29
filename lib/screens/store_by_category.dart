import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/single_store_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../controller/store_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreByCategoryListScreen extends StatefulWidget {
  const StoreByCategoryListScreen({Key? key}) : super(key: key);
  static var storeByCategoryScreen = "/storeByCategoryScreen";
  @override
  State<StoreByCategoryListScreen> createState() =>
      _StoreByCategoryListScreenState();
}

class _StoreByCategoryListScreenState extends State<StoreByCategoryListScreen> {
  final scrollController = ScrollController();
  final singleStoreController = Get.put(SingleStoreController());
  final nearStoreController = Get.put(StoreByCategoryController());
  final myCartController = Get.put(MyCartDataListController());
  final storeController = Get.put(StoreController());
  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      nearStoreController
          .getData(context: context)
          .then((value) => setState(() {}));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nearStoreController.getData(isFirstTime: true);
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        appBar: backAppBar(title: "Store", context: context),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Column(
              children: [
                Obx(() {
                  return nearStoreController.isDataLoading.value
                      ? nearStoreController.model.value.data!.isEmpty
                          ? const Center(
                              child: Text(
                                'Store Not Available',
                                style: TextStyle(
                                    color: AppTheme.blackcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '(${nearStoreController.model.value.data!.length}) Stores Near You',
                                  style: const TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Obx(() {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: nearStoreController
                                        .model.value.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                StoreScreen.singleStoreScreen);
                                            singleStoreController.storeId.value =
                                                nearStoreController
                                                    .model.value.data![index].id
                                                    .toString();
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppTheme.backgroundcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        AddSize.padding10,
                                                    vertical:
                                                        AddSize.padding10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: height * .19,
                                                      width: width,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              nearStoreController
                                                                  .model
                                                                  .value
                                                                  .data![index]
                                                                  .image
                                                                  .toString(),
                                                          errorWidget: (_, __,
                                                                  ___) =>
                                                              const SizedBox(),
                                                          placeholder: (_,
                                                                  __) =>
                                                              const SizedBox(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    addHeight(10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          nearStoreController
                                                              .model
                                                              .value
                                                              .data![index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .blackcolor,
                                                              fontSize: AddSize
                                                                  .font14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.location_on,
                                                              color: AppTheme
                                                                  .primaryColor,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * .02,
                                                            ),
                                                            Text(
                                                              "${nearStoreController.model.value.data![index].distance.toString()} KM",
                                                              style: TextStyle(
                                                                  color: AppTheme
                                                                      .blackcolor,
                                                                  fontSize:
                                                                      AddSize
                                                                          .font12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )));
                                    },
                                  );
                                }),
                                SizedBox(
                                  height: height * .04,
                                )
                              ],
                            )
                      : const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: CircularProgressIndicator(),
                        ));
                }),
                addHeight(30)
              ],
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: myCartController.isDataLoaded.value
            ? myCartController.model.value.data!.cartItems!.isNotEmpty
                ? addCartSection()
                : null
            : const SizedBox(),
      );
    });
  }
}
