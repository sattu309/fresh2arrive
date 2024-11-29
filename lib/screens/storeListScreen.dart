import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/store_controller.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/single_store_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final scrollController = ScrollController();
  final storeController = Get.put(StoreController());
  final singleStoreController = Get.put(SingleStoreController());


  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      storeController
          .getData(context: context)
          .then((value) => setState(() {}));
    }
  }

  final myCartController = Get.put(MyCartDataListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeController.getData();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: ()async{
           await storeController.getData();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16, vertical: AddSize.padding10),
              child: Column(
                children: [
                  Obx(() {
                    return storeController.isDataLoading.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .02,
                              ),
                              storeController.model.value.data!.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Store Not Available',
                                        style: TextStyle(
                                            color: AppTheme.backgroundcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '(${storeController.model.value.data!.length}) Stores Near You',
                                          style: const TextStyle(
                                              color: AppTheme.backgroundcolor,
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
                                            itemCount: storeController
                                                .model.value.data!.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                  onTap: () {
                                                    Get.toNamed(StoreScreen
                                                        .singleStoreScreen);
                                                    singleStoreController
                                                            .storeId.value =
                                                        storeController.model
                                                            .value.data![index].id
                                                            .toString();
                                                    setState(() {

                                                    });
                                                  },
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .backgroundcolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: AddSize
                                                                    .padding10,
                                                                vertical: AddSize
                                                                    .padding10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height * .19,
                                                              width: width,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: storeController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .image
                                                                      .toString(),
                                                                  errorWidget: (_,
                                                                          __,
                                                                          ___) =>
                                                                      const SizedBox(),
                                                                  placeholder: (_,
                                                                          __) =>
                                                                      const SizedBox(),
                                                                  fit: BoxFit
                                                                      .cover,
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
                                                                  storeController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: AppTheme
                                                                          .blackcolor,
                                                                      fontSize:
                                                                          AddSize
                                                                              .font14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: AppTheme
                                                                          .primaryColor,
                                                                      size: 20,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              .02,
                                                                    ),
                                                                    Text(
                                                                      "${storeController.model.value.data![index].distance.toString()} KM",
                                                                      style: TextStyle(
                                                                          color: AppTheme
                                                                              .blackcolor,
                                                                          fontSize:
                                                                              AddSize
                                                                                  .font12,
                                                                          fontWeight:
                                                                              FontWeight.w400),
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
                                    ),
                            ],
                          )
                        : Center(child: const CircularProgressIndicator());
                  }),
                  addHeight(30)
                ],
              ),
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
