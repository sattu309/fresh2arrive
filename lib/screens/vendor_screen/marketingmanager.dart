import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thank_you.dart';
import 'package:fresh2_arrive/screens/vendor_screen/thanku.dart';
import 'package:get/get.dart';
import '../../controller/VendorBankDetails_Controller.dart';
import '../../controller/vendor_BankList_controller..dart';
import '../../model/marketing_manager_model.dart';
import '../../repositories/maketingmanager_repo.dart';
import '../../repositories/vendor_registration_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../widgets/add_text.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/registration_form_textField.dart';

class MarketingManager extends StatefulWidget {
  static var marketingmanager = "/marketingmanager";

  const MarketingManager({Key? key}) : super(key: key);

  @override
  State<MarketingManager> createState() => _MarketingManagerState();
}

class _MarketingManagerState extends State<MarketingManager> {
  Rx<RxStatus> statusOfMarketing = RxStatus
      .empty()
      .obs;
  Rx<MarketingModel> maketingManager = MarketingModel().obs;
  final TextEditingController adharNoController = TextEditingController();
  final TextEditingController panNoController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController IFSCController = TextEditingController();
  final vendorBankListController = Get.put(VendorBankListController());
  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;
  Rx<File> image3 = File("").obs;
  Rx<File> image4 = File("").obs;
  RxString selectedCAt = "".obs;
  String? _address = "";
  final _formKey = GlobalKey<FormState>();
  RxBool showValidation = false.obs;

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset,
        duration: Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  getDataSubscription() {
    marketManagerRepo().then((value) {
      maketingManager.value = value;
      if (value.status == true) {
        Get.toNamed(ThankuScreen.thanku);

        statusOfMarketing.value = RxStatus.success();
      } else {
        showToast(value.message);
        statusOfMarketing.value = RxStatus.error();
      }
    }
      // showToast(value.message.toString());
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendorBankListController.getVendorBankListDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(
          title: "Apply for Marketing Partner", context: context),
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AddSize.padding16,
                          vertical: AddSize.padding10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegistrationTextField(
                            controller: adharNoController,
                            hint: "Aadhaar card number",
                            length: 12,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 12) {
                                return 'Please enter 12 digit Aadhaar card number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: panNoController,
                            length: 10,
                            hint: "Pan card number",
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Please enter 10 digit pan card number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          Text(
                            "Bank Details",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16),
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          Obx(() {
                            return vendorBankListController.isDataLoading.value ?
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade50,
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300),
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 3.0),
                                    borderRadius:
                                    BorderRadius.circular(15.0)),
                                enabled: true,
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select account',
                                style: TextStyle(
                                    color: AppTheme.userText,
                                    fontSize: AddSize.font14),
                              ),
                              value: selectedCAt.value == ""
                                  ? null
                                  : selectedCAt.value,
                              items: vendorBankListController
                                  .bankListModel.value.data!.banks!
                                  .toList()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(
                                    value.name.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCAt.value = newValue.toString();
                                });
                                print(selectedCAt.value);
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Account is required'),
                              ]),
                            ):SizedBox();
                          }),
                          // RegistrationTextField(
                          //   controller: bankNameController,
                          //   length: 10,
                          //   hint: "Bank Name",
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter bank name';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: accountHolderNameController,
                            hint: "Account Holder Name",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter account holder name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: accountNumberController,
                            length: 18,
                            hint: "Account Number",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 9) {
                                return 'Please enter account number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          RegistrationTextField(
                            controller: IFSCController,
                            hint: "IFSC Code",
                            length: 11,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 11) {
                                return 'Please enter IFSC code';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          Text(
                            "Upload Cancelled Check",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16),
                          ),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              width: AddSize.screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: !checkValidation(
                                        showValidation.value,
                                        image1.value.path == "")
                                        ? Colors.grey.shade300
                                        : Colors.red,
                                  )),
                              child: image1.value.path == ""
                                  ?
                              Column(
                                children: [
                                  Text(
                                    "Upload",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      NewHelper()
                                          .addFilePicker()
                                          .then((value) {
                                        image1.value = value;
                                      });
                                    },
                                    child: Container(
                                      height: AddSize.size45,
                                      width: AddSize.size45,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Colors
                                                  .grey.shade300)),
                                      child: Center(
                                          child: Image(
                                              height: AddSize.size25,
                                              width: AddSize.size25,
                                              color:
                                              Colors.grey.shade500,
                                              image: const AssetImage(
                                                  AppAssets
                                                      .camaraImage))),
                                    ),
                                  ),
                                ],
                              )

                                  : Stack(
                                children: [
                                  SizedBox(
                                      width: double.maxFinite,
                                      height: AddSize.size100,
                                      child: Image.file(image1.value)),

                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        NewHelper()
                                            .addFilePicker()
                                            .then((value) {
                                          image1.value = value;
                                        });
                                      },
                                      child: Container(
                                        height: AddSize.size30,
                                        width: AddSize.size30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppTheme
                                                    .backgroundcolor),
                                            color:
                                            AppTheme.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                50)),
                                        child: const Center(
                                            child: Icon(
                                              Icons.edit,
                                              color: AppTheme
                                                  .backgroundcolor,
                                              size: 20,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Text(
                            "Upload Pan Card",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16),
                          ),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              width: AddSize.screenWidth,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: !checkValidation(
                                        showValidation.value,
                                        image2.value.path == "")
                                        ? Colors.grey.shade300
                                        : Colors.red,
                                  )),
                              child: image2.value.path == ""
                                  ?
                              Column(
                                children: [
                                  Text(
                                    "Front",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: AddSize.size10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      NewHelper()
                                          .addFilePicker()
                                          .then((value) {
                                        image2.value = value;
                                      });
                                    },
                                    child: Container(
                                      height: AddSize.size45,
                                      width: AddSize.size45,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          border: Border.all(
                                              color: Colors
                                                  .grey.shade300)),
                                      child: Center(
                                          child: Image(
                                              height: AddSize.size25,
                                              width: AddSize.size25,
                                              color:
                                              Colors.grey.shade500,
                                              image: const AssetImage(
                                                  AppAssets
                                                      .camaraImage))),
                                    ),
                                  ),
                                ],
                              )

                                  : Stack(
                                children: [
                                  SizedBox(
                                      width: double.maxFinite,
                                      height: AddSize.size100,
                                      child: Image.file(image2.value)),

                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        NewHelper()
                                            .addFilePicker()
                                            .then((value) {
                                          image2.value = value;
                                        });
                                      },
                                      child: Container(
                                        height: AddSize.size30,
                                        width: AddSize.size30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppTheme
                                                    .backgroundcolor),
                                            color:
                                            AppTheme.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                50)),
                                        child: const Center(
                                            child: Icon(
                                              Icons.edit,
                                              color: AppTheme
                                                  .backgroundcolor,
                                              size: 20,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Text(
                            "Upload Adhar Card",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: AddSize.font16),
                          ),
                          SizedBox(
                            height: AddSize.padding12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  width: AddSize.screenWidth * .38,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: !checkValidation(
                                            showValidation.value,
                                            image3.value.path == "")
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                      )),
                                  child: image3.value.path == ""
                                      ?
                                  Column(
                                    children: [
                                      Text(
                                        "Front",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            image3.value = value;
                                          });
                                        },
                                        child: Container(
                                          height: AddSize.size45,
                                          width: AddSize.size45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Colors
                                                      .grey.shade300)),
                                          child: Center(
                                              child: Image(
                                                  height: AddSize.size25,
                                                  width: AddSize.size25,
                                                  color:
                                                  Colors.grey.shade500,
                                                  image: const AssetImage(
                                                      AppAssets
                                                          .camaraImage))),
                                        ),
                                      ),
                                    ],
                                  )

                                      : Stack(
                                    children: [
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          child: Image.file(image3.value)),

                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image3.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                                color:
                                                AppTheme.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppTheme
                                                      .backgroundcolor,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Obx(() {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  width: AddSize.screenWidth * .38,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: !checkValidation(
                                            showValidation.value,
                                            image4.value.path == "")
                                            ? Colors.grey.shade300
                                            : Colors.red,
                                      )),
                                  child: image4.value.path == ""
                                      ?
                                  Column(
                                    children: [
                                      Text(
                                        "Back",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          NewHelper()
                                              .addFilePicker()
                                              .then((value) {
                                            image4.value = value;
                                          });
                                        },
                                        child: Container(
                                          height: AddSize.size45,
                                          width: AddSize.size45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Colors
                                                      .grey.shade300)),
                                          child: Center(
                                              child: Image(
                                                  height: AddSize.size25,
                                                  width: AddSize.size25,
                                                  color:
                                                  Colors.grey.shade500,
                                                  image: const AssetImage(
                                                      AppAssets
                                                          .camaraImage))),
                                        ),
                                      ),
                                    ],
                                  )

                                      : Stack(
                                    children: [
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: AddSize.size100,
                                          child: Image.file(image4.value)),

                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            NewHelper()
                                                .addFilePicker()
                                                .then((value) {
                                              image4.value = value;
                                            });
                                          },
                                          child: Container(
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppTheme
                                                        .backgroundcolor),
                                                color:
                                                AppTheme.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppTheme
                                                      .backgroundcolor,
                                                  size: 20,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print("gggg");
                                if (_formKey.currentState!.validate() &&
                                    image1.value.path != "" &&
                                    image2.value.path != "" &&
                                    image3.value.path != "" &&
                                    image4.value.path != "") {
                                  Map<String, String> mapData = {
                                    'aadhar_no': adharNoController.text.trim(),
                                    'pan_no': panNoController.text.trim(),
                                    'bank': selectedCAt.value,
                                    'account_name': accountHolderNameController
                                        .text,
                                    'account_no': accountNumberController.text,
                                    'ifsc_code': IFSCController.text,
                                  };
                                  marketingManagerRegistrationRepo(
                                      context: context,
                                      mapData: mapData,
                                      fieldName2: "marketingManagerStatement",
                                      fieldName3: "marketingManagerPanImage",
                                      fieldName4: "marketingManagerAadharFront",
                                      fieldName5: "marketingManagerAadharBack",
                                      file2: image1.value,
                                      file3: image2.value,
                                      file4: image3.value,
                                      file5: image4.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      showToast("${value
                                          .message} Wait For Admin Approval");
                                      log(value.status.toString());
                                      Get.toNamed(ThankYouVendorScreen
                                          .thankYouVendorScreen);
                                    } else {
                                      showToast(value.message);
                                    }
                                  });
                                }
                                showValidation.value = true;
                                if (adharNoController.text
                                    .trim()
                                    .isEmpty) {
                                  scrollNavigation(10);
                                } else if (panNoController.text
                                    .trim()
                                    .isEmpty) {
                                  scrollNavigation(0);
                                } else if (bankNameController.text
                                    .trim()
                                    .isEmpty) {
                                  scrollNavigation(50);
                                } else if (accountHolderNameController.text
                                    .trim()
                                    .isEmpty) {
                                  scrollNavigation(50);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                backgroundColor: AppTheme.primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                "APPLY",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                    color: AppTheme.backgroundcolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              )),
                          SizedBox(
                            height: AddSize.size15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(
      //       horizontal: AddSize.padding16, vertical: AddSize.size40),
      //   child: ElevatedButton(
      //       onPressed: () {
      //         getDataSubscription();
      //
      //
      //
      //       },
      //       style: ElevatedButton.styleFrom(
      //           minimumSize: const Size(double.maxFinite, 60),
      //           backgroundColor: AppTheme.primaryColor,
      //           elevation: 0,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(AddSize.size10)),
      //           textStyle: TextStyle(
      //               fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
      //       child: Text(
      //         "Apply Now",
      //         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
      //             color: AppTheme.backgroundcolor,
      //             fontWeight: FontWeight.w500,
      //             fontSize: AddSize.font18),
      //       )),
      // ),
  }
}
