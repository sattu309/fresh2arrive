import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/controller/home_page_controller.dart';
import 'package:fresh2_arrive/controller/near_store_controller.dart';
import 'package:fresh2_arrive/repositories/Add_To_Cart_Repo.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/screens/store_by_category.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/cart_related_product_controller.dart';
import '../controller/category_controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/single_store_controller.dart';
import '../controller/store_by_category_controller.dart';
import '../controller/store_controller.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'SearchScreenData..dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static var homePage = "/homePage";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final homeSearchController = Get.put(HomePageController());
  final myCartController = Get.put(MyCartDataListController());
  final relatedCartController = Get.put(CartRelatedProductController());
  final viewAllController = Get.put(CategoryController());
  final locationController = Get.put(LocationController());
  final controller = Get.put(MainHomeController());
  final homeController = Get.put(HomePageController());
  final nearStoreController = Get.put(NearStoreController());
  final singleStoreController = Get.put(StoreController());
  final myOrderController = Get.put(MyOrderController());
  final storeCategoryController = Get.put(StoreByCategoryController());
  final profileController = Get.put(ProfileController());
  final addToCartQtyController = TextEditingController();
  final storeController = Get.put(SingleStoreController());
  RxString selectedCAt = "".obs;
  RxString price = "".obs;
  RxDouble sliderIndex = (0.0).obs;
  final scrollController = ScrollController();

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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async {
            nearStoreController.isPaginationLoading.value = true;
            nearStoreController.loadMore.value = true;
            await nearStoreController.getData(isFirstTime: true);
            profileController.getData();
            homeController.getData();
            myOrderController.getMyOrder();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: Column(
                  children: [
                    Obx(() {
                      return homeController.isDataLoading.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * .04,
                                ),
                                SizedBox(
                                  height: height * .07,
                                  child: TextField(
                                    maxLines: 1,
                                    controller:
                                        homeSearchController.searchController,
                                    style: const TextStyle(fontSize: 17),
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) => {},
                                    decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            // Get.to(const SearchScreenData());
                                            FocusManager.instance.primaryFocus!
                                                .unfocus();
                                            print(homeSearchController
                                                .searchController);
                                            Get.toNamed(
                                                SearchScreenData.searchScreen);
                                          },
                                          icon: const Icon(
                                            Icons.search_rounded,
                                            color: AppTheme.primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: width * .04),
                                        hintText: 'Search Your Groceries',
                                        hintStyle: TextStyle(
                                            fontSize: AddSize.font14,
                                            color: AppTheme.blackcolor,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .015,
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      onPageChanged: (value, _) {
                                        sliderIndex.value = value.toDouble();
                                      },
                                      autoPlayCurve: Curves.ease,
                                      height: height * .20),
                                  items: List.generate(
                                      homeController
                                          .model.value.data!.sliderData!.length,
                                      (index) => Container(
                                          width: width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: width * .01),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: AppTheme.backgroundcolor),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: homeController
                                                  .model
                                                  .value
                                                  .data!
                                                  .sliderData![index]
                                                  .image
                                                  .toString(),
                                              errorWidget: (_, __, ___) =>
                                                  const SizedBox(),
                                              placeholder: (_, __) =>
                                                  const SizedBox(),
                                              fit: BoxFit.cover,
                                            ),
                                          ))),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Obx(() {
                                  return Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DotsIndicator(
                                        dotsCount: homeController
                                            .model.value.data!.sliderData!.length,
                                        position: sliderIndex.value.toInt(),
                                        decorator: DotsDecorator(
                                          color: Colors
                                              .grey.shade300, // Inactive color
                                          activeColor: AppTheme.primaryColor,
                                          size: const Size.square(12),
                                          activeSize: const Size.square(12),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                const Text(
                                  'Best Fresh Product',
                                  style: TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                homeController.model.value
                                    .data!.bestFreshProduct!.isNotEmpty ?
                                SizedBox(
                                  height: height * .35,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.model.value
                                          .data!.bestFreshProduct!.length,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.only(top: height * .02),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return buildProduct(
                                            width, height, index, context);
                                      }),
                                ):const SizedBox(),
                                // SizedBox(
                                //   height: height * .02,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Get here what you want',
                                      style: TextStyle(
                                          color: AppTheme.blackcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.currentIndex.value = 0;
                                      },
                                      child: const Text(
                                        'View All',
                                        style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                                Obx(() {
                                  return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: homeController.model.value
                                          .data!.latestCategory!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 10.0,
                                              mainAxisExtent: 80,
                                              mainAxisSpacing: 10.0),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            storeCategoryController
                                                    .storeId.value =
                                                homeController.model.value.data!
                                                    .latestCategory![index].id
                                                    .toString();
                                            print(nearStoreController
                                                .storeId.value);
                                            Get.toNamed(
                                                StoreByCategoryListScreen
                                                    .storeByCategoryScreen);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: AddSize.size5,
                                                  vertical: AddSize.size5),
                                              decoration: BoxDecoration(
                                                  color: index % 3 == 0
                                                      ? AppTheme
                                                          .appPrimaryPinkColor
                                                      : index % 3 == 2
                                                          ? AppTheme
                                                              .appPrimaryGreenColor
                                                          : AppTheme
                                                              .appPrimaryYellowColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: AddSize.padding10,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height: AddSize.size50,
                                                      width: AddSize.size80,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10),
                                                        child:CachedNetworkImage(
                                                        imageUrl: homeController
                                                            .model
                                                            .value
                                                            .data!
                                                            .latestCategory![
                                                                index]
                                                            .image
                                                            .toString(),
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            const SizedBox(),
                                                        placeholder: (_, __) =>
                                                            const SizedBox(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )),
                                                    Text(
                                                      homeController
                                                          .model
                                                          .value
                                                          .data!
                                                          .latestCategory![
                                                              index]
                                                          .name
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: AppTheme
                                                              .subText,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        );
                                      });
                                }),
                                SizedBox(
                                  height: height * .02,
                                ),
                                const Text(
                                  'Featured Stores',
                                  style: TextStyle(
                                      color: AppTheme.blackcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                homeController.model.value
                                    .data!.featuredStores!.isNotEmpty ?
                                SizedBox(
                                  height: height * .33,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.model.value
                                          .data!.featuredStores!.length,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.only(top: height * .02),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: width * .03),
                                          child: Material(
                                            color: AppTheme.backgroundcolor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            elevation: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed(StoreScreen
                                                    .singleStoreScreen);
                                                storeController
                                                        .storeId.value =
                                                    homeController
                                                        .model
                                                        .value
                                                        .data!
                                                        .featuredStores![index]
                                                        .id
                                                        .toString();
                                                print(
                                                    "AAAAA-------${singleStoreController.storeId.value}");
                                              },
                                              child: Container(
                                                width: width * .5,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppTheme.backgroundcolor,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                // height: height * .23,
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: width * .03,
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height * .19,
                                                              width:
                                                                  width * .44,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: homeController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .featuredStores![
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
                                                            SizedBox(
                                                              height:
                                                                  height * .01,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    homeController
                                                                        .model
                                                                        .value
                                                                        .data!
                                                                        .featuredStores![
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
                                                                            FontWeight.w500)),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          .01,
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
                                                                      "${homeController.model.value.data!.featuredStores![index].distance.toString()}KM",
                                                                      style: TextStyle(
                                                                          color: AppTheme
                                                                              .blackcolor,
                                                                          fontSize: AddSize
                                                                              .font12,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ):const SizedBox(),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator());
                    }),
                    Obx(() {
                      return nearStoreController.isDataLoading.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * .02,
                                ),
                                nearStoreController.model.value.data == null
                                    ? const Text(
                                        'Stores Near You',
                                        style: TextStyle(
                                            color: AppTheme.blackcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(
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
                                    itemCount: nearStoreController.model.value.data == null ? 0 :nearStoreController
                                        .model.value.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                                StoreScreen.singleStoreScreen);
                                            storeController
                                                    .storeId.value =
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
                          : const SizedBox();
                    })
                  ],
                )),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: myCartController.isDataLoaded.value &&
                myCartController.model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null,
      );
    });
  }

  Padding buildProduct(
      double width, double height, int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width * .03),
      child: Material(
        color: AppTheme.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        elevation: 0,
        child: Container(
          width: width * .45,
          decoration: BoxDecoration(
            color: AppTheme.backgroundcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          // height: height * .23,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * .03,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .12,
                    width: width * .25,
                    child: CachedNetworkImage(
                      imageUrl: homeController
                          .model.value.data!.bestFreshProduct![index].image
                          .toString(),
                      errorWidget: (_, __, ___) => const SizedBox(),
                      placeholder: (_, __) => const SizedBox(),
                    ),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          homeController
                              .model.value.data!.bestFreshProduct![index].name
                              .toString(),
                          style: TextStyle(
                              color: AppTheme.blackcolor,
                              fontSize: AddSize.font14,
                              fontWeight: FontWeight.w500)),
                      buildDropdownButtonFormField(index),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].price.toString()}",
                              style: TextStyle(
                                  fontSize: AddSize.font14,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Text(
                            //   "Qty: ${homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].maxQty.toString()}",
                            //   style: TextStyle(
                            //       fontSize: AddSize.font14,
                            //       color: AppTheme.primaryColor,
                            //       fontWeight: FontWeight.w500),
                            // ),
                            myCartController.isDataLoaded.value
                                ? myCartController.model.value.data!.cartItems!
                                        .map((e) => e.variantId.toString())
                                        .toList()
                                        .contains(homeController
                                            .model
                                            .value
                                            .data!
                                            .bestFreshProduct![index]
                                            .varints![homeController
                                                .model
                                                .value
                                                .data!
                                                .bestFreshProduct![index]
                                                .varientIndex!
                                                .value]
                                            .id
                                            .toString())
                                    ? Container(
                                        width: width * .18,
                                        decoration: BoxDecoration(
                                            color: AppTheme.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: height * .005,
                                            horizontal: width * .01,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // removeCartItemRepo(singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varints![singleStoreController.storeDetailsModel.value.data!.latestProducts![index].varientIndex!.value].price.toString(), context);
                                                  if ((myCartController
                                                              .model
                                                              .value
                                                              .data!
                                                              .cartItems!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .variantId
                                                                          .toString() ==
                                                                      homeController
                                                                          .model
                                                                          .value
                                                                          .data!
                                                                          .bestFreshProduct![
                                                                              index]
                                                                          .varints![homeController
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .bestFreshProduct![
                                                                                  index]
                                                                              .varientIndex!
                                                                              .value]
                                                                          .id
                                                                          .toString(),
                                                                  orElse: () =>
                                                                      CartItems())
                                                              .cartItemQty ??
                                                          "0").toString() ==
                                                      homeController
                                                          .model
                                                          .value
                                                          .data!
                                                          .bestFreshProduct![
                                                              index]
                                                          .varints![homeController
                                                              .model
                                                              .value
                                                              .data!
                                                              .bestFreshProduct![
                                                                  index]
                                                              .varientIndex!
                                                              .value]
                                                          .minQty
                                                          .toString()) {
                                                    removeCartItemRepo(
                                                            (myCartController
                                                                        .model
                                                                        .value
                                                                        .data!
                                                                        .cartItems!
                                                                        .firstWhere(
                                                                            (element) =>
                                                                                element.variantId.toString() ==
                                                                                homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].id.toString(),
                                                                            orElse: () => CartItems())
                                                                        .id ??
                                                                    "0")
                                                                .toString(),
                                                            context)
                                                        .then((value) {
                                                      if (value.status ==
                                                          true) {
                                                        showToast(
                                                            value.message);
                                                        myCartController
                                                            .getAddToCartList();
                                                      } else {
                                                        showToast(
                                                            value.message);
                                                      }
                                                    });
                                                  } else {
                                                    addToCartRepo(
                                                            homeController
                                                                .model
                                                                .value
                                                                .data!
                                                                .bestFreshProduct![
                                                                    index]
                                                                .varints![homeController
                                                                    .model
                                                                    .value
                                                                    .data!
                                                                    .bestFreshProduct![
                                                                        index]
                                                                    .varientIndex!
                                                                    .value]
                                                                .id
                                                                .toString(),
                                                            homeController
                                                                .model
                                                                .value
                                                                .data!
                                                                .bestFreshProduct![
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            int.parse((myCartController
                                                                            .model
                                                                            .value
                                                                            .data!
                                                                            .cartItems!
                                                                            .firstWhere((element) => element.variantId.toString() == homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].id.toString(),
                                                                                orElse: () => CartItems())
                                                                            .cartItemQty ??
                                                                        "0")
                                                                    .toString()) -
                                                                1,
                                                            context)
                                                        .then((value) {
                                                      showToast(value.message);
                                                      if (value.status ==
                                                          true) {
                                                        myCartController
                                                            .getAddToCartList();
                                                      }
                                                      setState(() {});
                                                    });
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color:
                                                      AppTheme.backgroundcolor,
                                                  size: 15,
                                                ),
                                              ),
                                              Obx(() {
                                                return Text(
                                                  (myCartController.model.value
                                                              .data!.cartItems!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .variantId
                                                                          .toString() ==
                                                                      homeController
                                                                          .model
                                                                          .value
                                                                          .data!
                                                                          .bestFreshProduct![
                                                                              index]
                                                                          .varints![homeController
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .bestFreshProduct![
                                                                                  index]
                                                                              .varientIndex!
                                                                              .value]
                                                                          .id
                                                                          .toString(),
                                                                  orElse: () =>
                                                                      CartItems())
                                                              .cartItemQty ??
                                                          "")
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: AddSize.font14,
                                                      color: AppTheme
                                                          .backgroundcolor,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                );
                                              }),
                                              InkWell(
                                                onTap: () {
                                                  homeController
                                                              .model
                                                              .value
                                                              .data!
                                                              .bestFreshProduct![
                                                                  index]
                                                              .varints![homeController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .bestFreshProduct![
                                                                      index]
                                                                  .varientIndex!
                                                                  .value]
                                                              .maxQty !=
                                                          (myCartController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .cartItems!
                                                                  .firstWhere((element) => element.variantId.toString() == homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].id.toString(),
                                                                      orElse: () =>
                                                                          CartItems())
                                                                  .cartItemQty ??
                                                              "")
                                                      ? addToCartRepo(
                                                              homeController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .bestFreshProduct![
                                                                      index]
                                                                  .varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value]
                                                                  .id
                                                                  .toString(),
                                                              homeController.model.value.data!.bestFreshProduct![index].id.toString(),
                                                              int.parse((myCartController.model.value.data!.cartItems!.firstWhere((element) => element.variantId.toString() == homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].id.toString(), orElse: () => CartItems()).cartItemQty ?? "0").toString()) + 1,
                                                              context)
                                                          .then((value) {
                                                          showToast(
                                                              value.message);
                                                          if (value.status ==
                                                              true) {
                                                            myCartController
                                                                .getAddToCartList();
                                                          } else {
                                                            showToast(
                                                                value.message);
                                                          }
                                                        })
                                                      : showToast("You can't add more then ${homeController.model.value.data!.bestFreshProduct![index].varints![homeController.model.value.data!.bestFreshProduct![index].varientIndex!.value].maxQty.toString()} item");
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color:
                                                      AppTheme.backgroundcolor,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          minimumSize: Size(
                                              AddSize.size50, AddSize.size30),
                                          side: const BorderSide(
                                              color: AppTheme.primaryColor,
                                              width: 1),
                                          backgroundColor: AppTheme.addColor,
                                        ),
                                        onPressed: () {
                                          int vIndex = homeController
                                              .model
                                              .value
                                              .data!
                                              .bestFreshProduct![index]
                                              .varientIndex!
                                              .value;
                                          addToCartRepo(
                                                  homeController
                                                      .model
                                                      .value
                                                      .data!
                                                      .bestFreshProduct![index]
                                                      .varints![vIndex]
                                                      .id
                                                      .toString(),
                                                  homeController
                                                      .model
                                                      .value
                                                      .data!
                                                      .bestFreshProduct![index]
                                                      .id
                                                      .toString(),
                                                  homeController
                                                      .model
                                                      .value
                                                      .data!
                                                      .bestFreshProduct![index]
                                                      .varints![homeController
                                                          .model
                                                          .value
                                                          .data!
                                                          .bestFreshProduct![
                                                              index]
                                                          .varientIndex!
                                                          .value]
                                                      .minQty,
                                                  context)
                                              .then((value) {
                                            if (value.status == true) {
                                              showToast(value.message);
                                              myCartController.getAddToCartList();
                                              relatedCartController.getAddToCartRelatedList();
                                            } else {
                                              showToast(value.message);
                                            }
                                          });
                                        },
                                        child: Text("ADD",
                                            style: TextStyle(
                                                fontSize: AddSize.font12,
                                                color: AppTheme.primaryColor,
                                                fontWeight: FontWeight.w600)),
                                      )
                                : const SizedBox()
                          ],
                        );
                      }),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  buildDropdownButtonFormField(int index) {
    return Obx(() {
      return SizedBox(
        width: AddSize.size30 * 4,
        child: DropdownButtonFormField<int>(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade50,
              border: InputBorder.none,
              enabled: true,
            ),
            value: homeController
                .model.value.data!.bestFreshProduct![index].varientIndex!.value,
            items: List.generate(
                homeController
                    .model.value.data!.bestFreshProduct![index].varints!.length,
                (index1) => DropdownMenuItem(
                      value: index1,
                      child: Text(
                        "${homeController.model.value.data!.bestFreshProduct![index].varints![index1].variantQty} " " ${homeController.model.value.data!.bestFreshProduct![index].varints![index1].variantQtyType}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
            onChanged: (newValue) {
              homeController.model.value.data!.bestFreshProduct![index]
                  .varientIndex!.value = newValue!;
              setState(() {});
            }),
      );
    });
  }
}
