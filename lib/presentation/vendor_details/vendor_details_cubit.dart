import 'dart:async';
import 'dart:ui' as ui;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/report_entity.dart';
import 'package:berkania/domain/entities/review_entity.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/domain/repositories/review_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/domain/repositories/wishList_repository.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/extensions/validator.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/entities/vendor_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_image_strings.dart';
import '../widgets/custom_snackbars.dart';

part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final UserRepository userRepository;
  final VendorRepository vendorRepository;
  final ReviewRepository reviewRepository;
  final WishListRepository wishListRepository;
  final ReportRepository reportRepository;
  final GetStorage storage;
  String? uid;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  VendorDetailsCubit(
      {required this.userRepository,
      required this.vendorRepository,
      required this.reviewRepository,
      required this.wishListRepository,
      required this.reportRepository,
      required this.storage})
      : super(VendorDetailsLoadingState()) {
    init();
  }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{
    emit(VendorDetailsMainState(
      mapController:  Completer<GoogleMapController>(),
      vendor: VendorEntity(),
      wishListId: "",
      markers: const {},
      reviews: const [],
      feedbackController: TextEditingController(),
      feedback: 3.5,
      reportReason: "",
      feedBackFormState: GlobalKey<FormState>(),
      reportFormState: GlobalKey<FormState>()
    ));
    uid = await LocalStorage.read(key: "UID", storage: storage);

  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  void getVendorInfo({ required String argumentId,  required BuildContext context }) async{
   try{

     final VendorDetailsMainState currentState = state as VendorDetailsMainState;
     final VendorEntity? vendor = await vendorRepository.getVendorById(vendorId: argumentId);

     final markers = <Marker>{};
     if(vendor == null) return;

     final WishListEntity wishList = await wishListRepository.isFromWishList(userId: uid!, vendorId: vendor.id!) ?? WishListEntity();

     markers.add(await customMarker(lat: (vendor.shopLat ?? 0.0) as double, lng: (vendor.shopLng ?? 0.0) as double));

     emit(currentState.copyWith(vendor: vendor, markers: markers, wishListId: wishList.id));

   }catch(_){
     context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
   }
  }

  // - - - - - - - - - - - - - - - - - - ( INSERT / REMOVE ) WISHLISTS - - - - - - - - - - - - - - - - - -  //
  void upsertVendorWishList() async{
    final currentState = state as VendorDetailsMainState;
    final date = DateTime.now();
    String resultWishListId = "";
    emit(VendorDetailsLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    if(currentState.wishListId == "") {
      final WishListEntity wishListEntity = WishListEntity(
        userId: uid!,
        vendorId: currentState.vendor?.id,
        avatar: currentState.vendor?.avatar,
        fullName: "${currentState.vendor?.firstName} ${currentState.vendor?.lastName}",
        phone: currentState.vendor?.phoneNumber,
        rating: (currentState.vendor?.averageRating ?? 3.5).toDouble(),
        createAt: "${date.year}/${date.month}/${date.day}"
      );
      final result = await wishListRepository.insertWishList(wishListEntity: wishListEntity);
      resultWishListId = result;
    }
    else{
      await wishListRepository.deleteWishListById(id: currentState.wishListId!);
      resultWishListId = "";
    }

    emit(currentState.copyWith(wishListId: resultWishListId));
  }

  // - - - - - - - - - - - - - - - - - - GET ALL REVIEWS - - - - - - - - - - - - - - - - - -  //
  getReviews({ required String argumentId, required BuildContext context }) async{
    try{
      final VendorDetailsMainState currentState = state as VendorDetailsMainState;
      if(uid == null) return;
      final List<ReviewEntity> reviews = await reviewRepository.getReviews(id: argumentId);
      emit(currentState.copyWith(reviews: reviews));
    }
    catch(_){
    context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
    }
  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final VendorDetailsMainState updateState = state as VendorDetailsMainState;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - MARKER - - - - - - - - - - - - - - - - - -  //
  Future<Marker> customMarker({required double lat, required double lng}) async{
    final customIcon = BitmapDescriptor.fromBytes(await _getBytesFromAsset(CustomImageStrings.MARKER_SELLER, 120));
    return Marker(
        markerId: MarkerId("$lat $lng"),
        position: LatLng(lat, lng),
        icon: customIcon);
  }
  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  // - - - - - - - - - - - - - - - - - - ALERT FEEDBACK - - - - - - - - - - - - - - - - - -  //
  void onGiveFeedback({required BuildContext context, required Function callBack, required String argumentId }) async {

    final VendorDetailsMainState currentState = state as VendorDetailsMainState;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: 350,
              child: SingleChildScrollView(
                child: Form(
                  key: currentState.feedBackFormState,
                  child: Column(
                    children: [

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  TITLE - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.VENDOR_DETAILS_FEEDBACK_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6)),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  SUB TITLE 1 - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.VENDOR_DETAILS_FEEDBACK_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - -  RATING - - - - - - - - - - - - - - - - - -  //
                      Center(
                        child: RatingBar.builder(
                          itemCount: 5,
                          initialRating:  currentState.feedback!,
                          maxRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.zero,
                          itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                          onRatingUpdate: (double value) { emit(currentState.copyWith(feedback: value));  },
                        ),
                      ),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  SUB TITLE 2 - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - -  TEXT FILED- - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          hint: CustomLocale.VENDOR_DETAILS_FEEDBACK_HINT_TITLE.getString(context),
                          controller: currentState.feedbackController!,
                          leadingIcon: Iconsax.bookmark,
                          validator: (value) => Validator.validateEmptyField("FeedBack required", value)),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),

                      // - - - - - - - - - - - - - - - - - -  BUTTONS- - - - - - - - - - - - - - - - - -  //
                      Row(
                        children: [

                          // - - - - - - - - - - - - - - - - - -  CANCEL - - - - - - - - - - - - - - - - - -  //
                          Expanded(child: CustomElevatedButton(onClick: context.pop, height: 78, withDefaultPadding: false, child: Text(CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_CANCEL.getString(context)))),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),

                          // - - - - - - - - - - - - - - - - - -  SUBMIT - - - - - - - - - - - - - - - - - -  //
                          Expanded(child: CustomElevatedButton(onClick: () async{

                            // CHECK THE FORM
                            if(!currentState.feedBackFormState!.currentState!.validate()) return;

                            if(uid == null) return;


                            final UserEntity? userEntity = await userRepository.getUserInfo(id: uid!);

                            if(userEntity == null) return;

                            final date = DateTime.now();
                            final ReviewEntity review = ReviewEntity(
                              vendorId: argumentId,
                              fullName: "${userEntity.firstName} ${userEntity.lastName}",
                              reviewBody: currentState.feedbackController!.text.trim(),
                              avatar: userEntity.avatar,
                              rating: currentState.feedback!,
                              createAt: "${date.day}/${date.month}/${date.year}"
                            );
                            await reviewRepository.insert(reviewEntity: review);

                            currentState.feedbackController!.clear();

                            callBack.call();

                          }, height: 78, withDefaultPadding: false, child: Text(CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_SUBMIT.getString(context)))),

                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - - ALERT REPORT - - - - - - - - - - - - - - - - - -  //
  void onReport({required BuildContext context, required Function callBack}) async {
    final VendorDetailsMainState currentState = state as VendorDetailsMainState;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: 350,
              child: SingleChildScrollView(
                child: Form(
                  key: currentState.reportFormState,
                  child: Column(
                    children: [

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  TITLE - - - - - - - - - - - - - - - - - -  //
                      Text(
                          CustomLocale.VENDOR_DETAILS_REPORT_TITLE.getString(context),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6),
                      ),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  SUB TITLE 1 - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.VENDOR_DETAILS_REPORT_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                          style: Theme.of(context).textTheme.bodyLarge,
                          items:[
                            DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                            DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_2.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_2.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                            DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_3.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_3.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                            DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_4.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_4.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                            DropdownMenuItem(value: CustomLocale.VENDOR_DETAILS_REPORT_REASON_5.getString(context), child: Text(CustomLocale.VENDOR_DETAILS_REPORT_REASON_5.getString(context), overflow: TextOverflow.ellipsis, maxLines: 1)),
                          ],
                          onChanged: (String? value) {
                            emit(currentState.copyWith(reportReason: value));
                          },
                          icon: const Icon(Iconsax.arrow_bottom),
                          value: currentState.reportReason == "" ? CustomLocale.VENDOR_DETAILS_REPORT_REASON_1.getString(context) : currentState.reportReason ),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - -  SUB TITLE 2 - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - -  TEXT FILED- - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          hint: CustomLocale.VENDOR_DETAILS_FEEDBACK_HINT_TITLE.getString(context),
                          controller: currentState.feedbackController!,
                          leadingIcon: Iconsax.bookmark,
                          validator: (value) => Validator.validateEmptyField("Report required", value)),

                      // - - - - - - - - - - - - - - - - - -  BUTTONS- - - - - - - - - - - - - - - - - -  //
                      Row(
                        children: [

                          // - - - - - - - - - - - - - - - - - -  CANCEL - - - - - - - - - - - - - - - - - -  //
                          Expanded(child: CustomElevatedButton(onClick: context.pop, height: 78, withDefaultPadding: false, child: Text(CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_CANCEL.getString(context)))),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS  / 2),

                          // - - - - - - - - - - - - - - - - - -  SUBMIT - - - - - - - - - - - - - - - - - -  //
                          Expanded(child: CustomElevatedButton(onClick: () async{

                            // CHECK THE FORM
                            if(!currentState.reportFormState!.currentState!.validate()) return;

                            if(uid == null) return;

                            final UserEntity? userEntity = await userRepository.getUserInfo(id: uid!);

                            if(userEntity == null) return;

                            final date = DateTime.now();
                            final ReportEntity report = ReportEntity(
                                vendorId: uid,
                                fullName: "${userEntity.firstName} ${userEntity.lastName}",
                                reportType: currentState.reportReason,
                                reportBody: currentState.feedbackController!.text.trim(),
                                avatar: userEntity.avatar,
                                rating: currentState.feedback!,
                                createAt: "${date.day}/${date.month}/${date.year}"
                            );
                            await reportRepository.insert(reportEntity: report);

                            currentState.feedbackController!.clear();

                            callBack.call();

                          }, height: 78, withDefaultPadding: false, child: Text(CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_SUBMIT.getString(context)))),

                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

}
